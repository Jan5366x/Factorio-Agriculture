import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Locale;
import java.util.Objects;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Build Factorio Agriculture Mod - Zip File
 * java single file execution - java 15
 */
public class Build {
    private final static String PROJECT_DIR = "Factorio-Agriculture";
    private final static String MOD_SUB_DIR = "Factorio-Agriculture";
    private final static String BUILD_DIR = "build";

    private final static String CONSOLE_SEP = "-".repeat(120);

    public static void main(String[] args) throws Exception {
        System.out.println(CONSOLE_SEP);
        System.out.println(PROJECT_DIR + " Build");
        System.out.println(CONSOLE_SEP);
        prepareModBuildFolder();
        System.out.println(CONSOLE_SEP);
        copyModFiles();
        System.out.println(CONSOLE_SEP);
        renameAndZipMod();
        System.out.println(CONSOLE_SEP);
        System.out.println("Build successfully!");
    }

    private static void prepareModBuildFolder() throws Exception {
        System.out.println("Prepare mod build folder ...");
        System.out.println(CONSOLE_SEP);

        var directory = new File(BUILD_DIR);

        System.out.println("Build dir: " + directory.getAbsolutePath());
        var expectedDirStructure = PROJECT_DIR + File.separator + BUILD_DIR;
        System.out.println("Expected build dir structure: " + expectedDirStructure);

        // sanity check
        if (!directory.getAbsolutePath().contains(expectedDirStructure))
            throw new IOException("Build dir don't met the expected folder structure!");


        if (directory.exists()) {
            System.out.println("Build dir detected!\n\t-> Content will be purged!");
            purgeDirectory(directory);
        } else {
            System.out.println("Build dir don't exists!\n\t-> Empty build dir will be created!");
            directory.mkdir();
        }
    }

    private static void copyModFiles() throws Exception  {
        System.out.println("Copy mod files...");
        System.out.println(CONSOLE_SEP);

        var sourceDir = new File(MOD_SUB_DIR);
        var destination = new File(BUILD_DIR + File.separator + MOD_SUB_DIR);
        copyDirectory(sourceDir.getAbsolutePath(), destination.getAbsolutePath());
    }

    private static void renameAndZipMod() throws Exception  {
        System.out.println("Rename mod folder and create zip file...");
        System.out.println(CONSOLE_SEP);

        var version = fetchModVersionString();
        System.out.println("Mod version: " + version);

        var name = MOD_SUB_DIR.toLowerCase(Locale.ENGLISH) + "_" + version;
        System.out.println("Mod name: " + name);

        var zipName = new File(BUILD_DIR + File.separator + name + ".zip").getAbsolutePath();
        var rawModFolder = new File( BUILD_DIR + File.separator + MOD_SUB_DIR);
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

    public static Path renameDirectory(String dirPath, String newName) throws Exception {
        var source = Paths.get(dirPath);
        return Files.move(source, source.resolveSibling(newName));
    }

    public static void copyDirectory(String sourceDirectoryLocation, String destinationDirectoryLocation)
            throws IOException {

        System.out.println("Copy Directory\n\tFrom: " + sourceDirectoryLocation + "\n\tTo: " + destinationDirectoryLocation);

        Files.walk(Paths.get(sourceDirectoryLocation))
                .forEach(source -> {
                    var destination = Paths.get(destinationDirectoryLocation, source.toString()
                            .substring(sourceDirectoryLocation.length()));
                    try {
                        Files.copy(source, destination);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                });
    }

    private static void purgeDirectory(File dir) {
        for (File file: Objects.requireNonNull(dir.listFiles())) {
            if (file.isDirectory())
                purgeDirectory(file);
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

            for (File childFile : Objects.requireNonNull(children))
                zipFile(childFile, fileName + "/" + childFile.getName(), zipOut);

            return;
        }
        try(var fis = new FileInputStream(fileToZip)) {
            var zipEntry = new ZipEntry(fileName);
            zipOut.putNextEntry(zipEntry);
            var bytes = new byte[1024];

            int length;
            while ((length = fis.read(bytes)) >= 0)
                zipOut.write(bytes, 0, length);
        }
    }
}