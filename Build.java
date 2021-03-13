import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
/**
 * Build Factorio Agriculture Mod - Zip File
 * java single file execution - java 15
 */
public class Build {
    private final static String BUILD_SCRIPT_VERSION = "1.2.5";
    private final static String PROJECT_DIR = "Factorio-Agriculture";
    private final static String MOD_SUB_DIR = "Factorio-Agriculture";
    private final static String BUILD_DIR = "Build";

    private final static List<String> filesToCleanup = List.of(".keep", "thumbs.db", "desktop.ini");

    private final static String os = System.getProperty("os.name").toLowerCase();
    private final static String userHome = System.getProperty("user.home");

    private static int warningCount = 0;

    public static void main(String[] args) {
        try {
            var arguments = Arrays.asList(args);
            println(CONSOLE_SEP, ASCII_LOGO);

            listArguments(arguments);
            verifyTranslation();
            verifyGraphics();
            prepareModBuildFolder();
            copyModFiles();
            cleanupModFolder();
            renameAndZipMod();

            if (arguments.contains("-localdeploy")) {
                localDeploy();
            }

            println(CONSOLE_SEP, ASCII_LOGO, CONSOLE_SEP,
                    warningCount == 0
                            ? "✓ Build successfully!"
                            : "⚠ Build finished with " + warningCount + " warning(s)!");

        } catch (Exception e) {
            e.printStackTrace(System.out);
            System.exit(1);
        }
    }

    private static void verifyGraphics() {
        println(CONSOLE_SEP, "Verify Graphics...", CONSOLE_SEP);

        // TODO implement test for placeholder files
        warn("Verify graphics check not implemented!");
    }

    private static void warn(String message) {
        println("⚠ " + message);
        warningCount++;
    }

    private static void localDeploy() throws Exception {
        if (isUnix()) {
            localDeploy(new File(userHome + "/.factorio/mods"));
        } else if (isWindows()) {
            localDeploy(new File(userHome + "\\AppData\\Roaming\\Factorio\\mods"));
        } else {
            println("Local Deployment FAILED! (OS not supported!)");
        }
    }

    private static void localDeploy(final File targetDir) throws Exception {
        println(CONSOLE_SEP, "Local Deployment - " + os.toUpperCase(), CONSOLE_SEP);
        println("Local deploy target: " + targetDir.getAbsolutePath());

        if (!targetDir.isDirectory())
            throw new Exception("Target dir is not a directory! (" + targetDir.getAbsolutePath() +  ")");

        var zipFileName = getModZipName() + ".zip";
        var zip = new File(BUILD_DIR + File.separator + zipFileName);
        println("Build File: " + zip.getAbsolutePath());
        Files.copy(zip.toPath(), targetDir.toPath().resolve(zipFileName), StandardCopyOption.REPLACE_EXISTING);
    }

    private static void listArguments(List<String> arguments) {
        println(CONSOLE_SEP, "Arguments: " + String.join("; ", arguments), CONSOLE_SEP);
    }

    private static void verifyTranslation() throws IOException {
        Set<String> protoTypeNames = new HashSet<>();
        loadPrototypeNames(protoTypeNames, "item", "item-name");
        loadPrototypeNames(protoTypeNames, "entities", "entity-name");

        boolean hasDelta = false;

        for (String language : Arrays.asList("de", "en")) {
            println("Delta for language " + language + ":");

            Set<String> languageNames = loadLanguageFile(language);
            HashSet<String> missingInLanguage = new HashSet<>(protoTypeNames);
            missingInLanguage.removeAll(languageNames);
            if (!missingInLanguage.isEmpty()) {
                hasDelta = true;
                println("Missing in language file: ");
                for (String s : missingInLanguage) {
                    println(s);
                }
            }

            HashSet<String> missingInPrototypes = new HashSet<>(languageNames);
            missingInPrototypes.removeAll(protoTypeNames);
            if (!missingInPrototypes.isEmpty()) {
                hasDelta = true;
                println("Missing in prototypes file: ");
                for (String s : missingInPrototypes) {
                    println(s);
                }
            }
        }

        if (hasDelta) {
            throw new IllegalStateException("Will not build mod archive. Fix your translation first!");
        }
    }

    private static Set<String> loadLanguageFile(String language) throws IOException {
        Set<String> languageEntries = new HashSet<>();
        List<String> prototypes = Files.readAllLines(Path.of(MOD_SUB_DIR, "locale", language, "main.cfg"));
        var iniSection = "";

        int line = 0;
        for (String prototype : prototypes) {
            line++;
            String trimmed = prototype.trim();
            if (!trimmed.isEmpty()) {
                if (trimmed.startsWith("[") && trimmed.endsWith("]")) {
                    iniSection = trimmed.substring(1, trimmed.length() - 1);
                } else {
                    int toSplit = trimmed.indexOf('=');
                    if (toSplit < 1) {
                        throw new IllegalStateException("Language files invalid in line " + line + ": Missing =");
                    }
                    String name = trimmed.substring(0, toSplit);
                    if (iniSection.isEmpty()) {
                        throw new IllegalStateException(
                                "Language files invalid in line " + line + ": No ini section started");
                    }
                    languageEntries.add(iniSection + "." + name);
                }
            }
        }
        return languageEntries;
    }

    private static void loadPrototypeNames(Set<String> protoTypeNames, String filename, String prefix)
            throws IOException {
        List<String> prototypes = Files.readAllLines(Path.of(MOD_SUB_DIR, "prototypes", filename + ".lua"));
        for (String prototype : prototypes) {
            String trimmed = prototype.trim();
            if (trimmed.startsWith("name = \"")) {
                String itemName = trimmed.substring(8, trimmed.length() - 2);
                protoTypeNames.add(prefix + "." + itemName);
            }
        }
    }

    private static void prepareModBuildFolder() throws Exception {
        println(CONSOLE_SEP, "Prepare mod build folder...", CONSOLE_SEP);

        var directory = new File(BUILD_DIR);

        println("build dir: " + directory.getAbsolutePath());
        var expectedDirStructure = PROJECT_DIR + File.separator + BUILD_DIR;
        println("expected build dir structure: " + expectedDirStructure);

        // sanity check
        if (!directory.getAbsolutePath().contains(expectedDirStructure)) {
            throw new IOException("Build dir don't met the expected folder structure!");
        }


        if (directory.exists()) {
            println("Build dir detected!\n-> Content will be purged!");
            purgeDirectory(directory);
        } else {
            println("Build dir don't exists!\n-> Empty build dir will be created!");
            directory.mkdir();
        }
    }

    private static void copyModFiles() throws Exception {
        println(CONSOLE_SEP, "Copy mod files...", CONSOLE_SEP);

        var sourceDir = new File(MOD_SUB_DIR);
        var destination = new File(BUILD_DIR + File.separator + MOD_SUB_DIR);
        copyDirectory(sourceDir.getAbsolutePath(), destination.getAbsolutePath());
    }

    private static void cleanupModFolder() throws Exception {
        println(CONSOLE_SEP, "Cleanup...", CONSOLE_SEP);

        filesToCleanup.forEach(s -> println("-> " + s));

        var dir = new File(BUILD_DIR + File.separator + MOD_SUB_DIR);
        try (var paths = Files.walk(dir.toPath())) {
            paths
                    .filter(Build::cleanupFilter)
                    .forEach(Build::deleteFile);
        }
    }

    private static boolean cleanupFilter(Path path) {
        if (!Files.isRegularFile(path)) {
            return false;
        }

        var fileName = path.getFileName().toString();

        return filesToCleanup.stream().anyMatch(s -> s.equalsIgnoreCase(fileName));
    }

    private static String getModZipName() throws Exception {
        return getModZipName(fetchModVersionString());
    }

    private static String getModZipName(final String version) {
        return MOD_SUB_DIR.toLowerCase(Locale.ENGLISH) + "_" + version;
    }

    private static void renameAndZipMod() throws Exception {
        println(CONSOLE_SEP, "Rename mod folder and create zip file...", CONSOLE_SEP);

        var version = fetchModVersionString();
        println("Mod version: " + version);

        var name = getModZipName(version);
        println("Mod name: " + name);

        var zipName = new File(BUILD_DIR + File.separator + name + ".zip").getAbsolutePath();
        var rawModFolder = new File(BUILD_DIR + File.separator + MOD_SUB_DIR);
        var preparedModFolder = renameDirectory(rawModFolder.getAbsolutePath(), name);

        try (var fos = new FileOutputStream(zipName); var zipOut = new ZipOutputStream(fos)) {
            var fileToZip = preparedModFolder.toFile();
            zipFile(fileToZip, fileToZip.getName(), zipOut);
        }
    }

    private static String fetchModVersionString() throws Exception {
        var infoJson = new File(MOD_SUB_DIR + File.separator + "info.json");
        var allLines = Files.readAllLines(infoJson.toPath());
        for (var line : allLines) {
            if (line.contains("\"version\":")) {
                return line
                        .trim()
                        .toLowerCase(Locale.ENGLISH)
                        .replace("\"version\":", "")
                        .replace("\"", "")
                        .replace(",", "")
                        .trim();
            }
        }

        throw new Exception("Mod version not found!");
    }

    public static void deleteFile(final Path path) {
        try {
            Files.delete(path);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static Path renameDirectory(String dirPath, String newName) throws Exception {
        var source = Paths.get(dirPath);
        return Files.move(source, source.resolveSibling(newName));
    }

    public static void copyDirectory(String sourceDirectoryLocation, String destinationDirectoryLocation)
            throws IOException {

        println("Copy Directory\nFrom: " + sourceDirectoryLocation + "\nTo: " + destinationDirectoryLocation);

        final var filesCopied = new AtomicInteger();
        Files.walk(Paths.get(sourceDirectoryLocation))
                .forEach(source -> {
                    var destination = Paths.get(destinationDirectoryLocation, source.toString()
                            .substring(sourceDirectoryLocation.length()));
                    try {
                        Files.copy(source, destination);
                        filesCopied.incrementAndGet();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                });

        println("-> " + filesCopied.get() + " files copied!");
    }

    private static void purgeDirectory(File dir) {
        for (File file : Objects.requireNonNull(dir.listFiles())) {
            if (file.isDirectory()) {
                purgeDirectory(file);
            }
            file.delete();
        }
    }

    private static void zipFile(File fileToZip, String fileName, ZipOutputStream zipOut) throws IOException {
        if (fileToZip.isHidden()) {
            return;
        }
        if (fileToZip.isDirectory()) {
            if (fileName.endsWith("/")) {
                zipOut.putNextEntry(new ZipEntry(fileName));
                zipOut.closeEntry();
            } else {
                zipOut.putNextEntry(new ZipEntry(fileName + "/"));
                zipOut.closeEntry();
            }
            var children = fileToZip.listFiles();

            for (File childFile : Objects.requireNonNull(children)) {
                zipFile(childFile, fileName + "/" + childFile.getName(), zipOut);
            }

            return;
        }
        try (var fis = new FileInputStream(fileToZip)) {
            var zipEntry = new ZipEntry(fileName);
            zipOut.putNextEntry(zipEntry);
            var bytes = new byte[1024];

            int length;
            while ((length = fis.read(bytes)) >= 0) {
                zipOut.write(bytes, 0, length);
            }
        }
    }
    public static boolean isWindows() {
        return os.contains("win");
    }

    public static boolean isMac() {
        return os.contains("mac");
    }

    public static boolean isUnix() {
        return (os.contains("nix") || os.contains("nux") || os.contains("aix"));
    }

    private static void println(final String... lines) {
        for (String line : lines) {
            System.out.println(line);
        }
    }

    private final static String CONSOLE_SEP = "-".repeat(79);

    private final static String ASCII_LOGO =
            "     ______            _                _\n" +
                    "    |  ____|          | |              (_)                              \n" +
                    "    | |__  __ _   ___ | |_  ___   _ __  _   ___                         \n" +
                    "    |  __|/ _` | / __|| __|/ _ \\ | '__|| | / _ \\                        \n" +
                    "    | |  | (_| || (__ | |_| (_) || |   | || (_) |                       \n" +
                    "    |_|   \\__,_| \\___| \\__|\\___/ |_|   |_| \\___/  _                     \n" +
                    "                /\\                (_)             | || |                    \n" +
                    "               /  \\    __ _  _ __  _   ___  _   _ | || |_  _   _  _ __  ___ \n" +
                    "              / /\\ \\  / _` || '__|| | / __|| | | || || __|| | | || '__|/ _ \\\n" +
                    "             / ____ \\| (_| || |   | || (__ | |_| || || |_ | |_| || |  |  __/\n" +
                    "            /_/    \\_\\\\__, ||_|   |_| \\___| \\__,_||_| \\__| \\__,_||_|   \\___|\n" +
                    "                       __/ |                     Build Script Version v" + BUILD_SCRIPT_VERSION +
                    "\n" +
                    "                      |___/";
}