import java.awt.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.regex.Pattern;
import java.util.stream.Stream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Build Factorio Agriculture Mod - Zip File
 * java single file execution - java 16
 */
public class Build {
    private final static String BUILD_SCRIPT_VERSION = "1.3.4";
    private final static String PROJECT_DIR = "Factorio-Agriculture";
    private final static String MOD_SUB_DIR = "Factorio-Agriculture";
    private final static String BUILD_DIR = "Build";
    private final static Path ASSET_DIR = Paths.get("Assets");
    private final static Path ASSET_INVENTORY_DIR = ASSET_DIR.resolve("inventory");
    private final static List<String> SUPPORTED_LANGUAGES = Arrays.asList("de", "en");
    private final static Pattern GRAPHICS_NAME_PATTERN = Pattern.compile("=[ \t]*\"(.*)\"");
    private final static String MOD_BASE_REFERENCE = "__factorio-agriculture__";

    private final static Map<String, Boolean> LUA_BOOLEAN_TEXTS = new HashMap<>();

    {
        Map<String, Boolean> luaBooleanTexts = new HashMap<>();
        luaBooleanTexts.put("true", true);
        luaBooleanTexts.put("false", false);
        luaBooleanTexts.put("yes", true);
        luaBooleanTexts.put("no", false);
        LUA_BOOLEAN_TEXTS.putAll(luaBooleanTexts);
    }

    private final static char[] LUA_BOOLEAN_CHARS = new char[]{'t', 'r', 'u', 'e', 'f', 'a', 'l', 's', 'y', 'n', 'o'};

    private final static List<String> filesToCleanup = List.of(".keep", "thumbs.db", "desktop.ini");
    private final static String os = System.getProperty("os.name").toLowerCase();
    private final static String userHome = System.getProperty("user.home");

    private static int warningCount = 0;
    private static boolean deployed = false;

    public static void main(String[] args) {
        try {
            var arguments = Arrays.asList(args);
            println(CONSOLE_SEP, ASCII_LOGO);

            listArguments(arguments);
            verifyTranslation();
            verifyGraphics();
            verifyAssetInventory();
            prepareModBuildFolder();
            copyModFiles();
            cleanupModFolder();
            renameAndZipMod();

            if (arguments.contains("-localdeploy")) {
                localDeploy();
            }

            if (arguments.contains("-launch")) {
                launchGame();
            }

            println(CONSOLE_SEP, ASCII_LOGO, CONSOLE_SEP,
                    warningCount == 0
                            ? "✓ Build successfully!"
                            : "⚠ Build finished with " + warningCount + " warning(s)!");
            System.exit(warningCount == 0 ? 0 : 1);
        } catch (Exception e) {
            e.printStackTrace(System.out);
            System.exit(1);
        }
    }

    private static void warn(String message, int tabs) {
        println("\t".repeat(tabs) + "⚠ " + message);
        warningCount++;
    }

    private static void warn(String message) {
        warn(message, 0);
    }

    private static void success(String message) {
        println("✓ " + message);
    }

    private static void launchGame() throws IOException, URISyntaxException, InterruptedException {
        println(CONSOLE_SEP, "Launching Game", CONSOLE_SEP);

        if (!deployed) {
            warn("Factorio can't be launched without new deployment! (add: -localdeploy)");
            return;
        }
        if (Desktop.isDesktopSupported()) {
            Desktop.getDesktop().browse(new URI("steam://run/427520/"));
            // Wait for OS to take over and detach steam runner form current process.
            Thread.sleep(5000);
        } else {
            warn("This system don't support the launch game feature!");
        }
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

        if (!targetDir.isDirectory()) {
            throw new Exception("Target dir (" + targetDir.getAbsolutePath() + ") is not a directory! Did you install factorio yet?");
        }

        var zipFileName = getModZipName() + ".zip";
        var zip = new File(BUILD_DIR + File.separator + zipFileName);
        println("Build File: " + zip.getAbsolutePath());
        Files.copy(zip.toPath(), targetDir.toPath().resolve(zipFileName), StandardCopyOption.REPLACE_EXISTING);
        deployed = true;
    }

    private static void listArguments(List<String> arguments) {
        println(CONSOLE_SEP, "Arguments: " + String.join("; ", arguments), CONSOLE_SEP);
    }

    private static void verifyTranslation() throws IOException {
        println(CONSOLE_SEP, "Verify Translations...", CONSOLE_SEP);

        Set<String> protoTypeNames = new HashSet<>();
        loadPrototypeNames(protoTypeNames, "item", "item-name");
        loadPrototypeNames(protoTypeNames, "entities", "entity-name");
        loadPrototypeNames(protoTypeNames, "recipe", "recipe-name");
        loadPrototypeNames(protoTypeNames, "technology", "technology-name");
        loadPrototypeNames(protoTypeNames, "fluid", "fluid-name");

        for (var language : SUPPORTED_LANGUAGES) {
            Set<String> languageNames = loadLanguageFile(language);
            HashSet<String> missingInLanguage = new HashSet<>(protoTypeNames);
            HashSet<String> missingInPrototypes = new HashSet<>(languageNames);
            missingInLanguage.removeAll(languageNames);
            missingInPrototypes.removeAll(protoTypeNames);

            if (missingInLanguage.isEmpty() && missingInPrototypes.isEmpty()) {
                success("Language " + language + " is all good");
            } else {
                println("Delta for language " + language + ":");
            }

            if (!missingInLanguage.isEmpty()) {
                List<String> missingInLanguageSorted = new ArrayList<>(missingInLanguage);
                missingInLanguageSorted.sort(Comparator.naturalOrder());
                println("\tMissing in language file: ");
                for (var str : missingInLanguageSorted) {
                    warn(str, 2);
                }
            }

            if (!missingInPrototypes.isEmpty()) {
                List<String> missingInPrototypesSorted = new ArrayList<>(missingInPrototypes);
                missingInPrototypesSorted.sort(Comparator.naturalOrder());
                println("\tMissing in prototypes file: ");
                for (var str : missingInPrototypesSorted) {
                    warn(str, 2);
                }
            }
        }
    }

    private static void verifyGraphics() throws IOException {
        println(CONSOLE_SEP, "Verify Graphics...", CONSOLE_SEP);

        var graphicsNames = new ArrayList<String>();

        loadGraphicsNames(graphicsNames, "item");
        loadGraphicsNames(graphicsNames, "item-groups");
        loadGraphicsNames(graphicsNames, "technology");
        loadGraphicsNames(graphicsNames, "recipe");
        loadGraphicsNames(graphicsNames, "recipe-category");
        loadGraphicsNames(graphicsNames, "entities");
        loadGraphicsNames(graphicsNames, "fluid");

        if (!graphicsNames.isEmpty()) {
            println("Problems found for:");
            graphicsNames.forEach(Build::warn);
        }
    }

    private static void verifyAssetInventory() throws IOException {
        println(CONSOLE_SEP, "Verify Asset Inventory...", CONSOLE_SEP);
        verifyAssetInventory("item");
        verifyAssetInventory("item-groups");
        verifyAssetInventory("technology");
        verifyAssetInventory("recipe");
        verifyAssetInventory("recipe-category");
        verifyAssetInventory("entities");
        verifyAssetInventory("fluid");
        verifyAssetInventory("technology");
    }

    private static void verifyAssetInventory(String filename) throws IOException {
        var inventoryNames = new ArrayList<String>();

        // load csv lines, just use first column and ignore the title "name"
        try (Stream<String> stream = Files.lines(ASSET_INVENTORY_DIR.resolve(filename + ".csv"))) {
            stream.forEach(s -> {
                if (s.trim().isEmpty()) {
                    return;
                }
                var name = s.split(",")[0];
                if (!name.equalsIgnoreCase("name")) {
                    inventoryNames.add(name);
                }
            });
        }

        var prototypes = Files.readAllLines(Path.of(MOD_SUB_DIR, "prototypes", filename + ".lua"));

        for (var prototype : prototypes) {
            var trimmed = prototype.trim();
            if (trimmed.startsWith("name = \"")) {
                var name = trimmed.substring(8, trimmed.endsWith(",") ? trimmed.length() - 2 : trimmed.length() - 1);
                inventoryNames.remove(name);
            }
        }

        inventoryNames.forEach(s -> warn(filename + " " + s + " is missing!"));
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

    private static void loadGraphicsNames(List<String> iconNames, String filename) throws IOException {
        var prototypes = Files.readAllLines(Path.of(MOD_SUB_DIR, "prototypes", filename + ".lua"));
        var name = "";
        var lineIdx = 0;
        for (String prototype : prototypes) {
            lineIdx++;
            String trimmed = prototype.trim();
            if (trimmed.startsWith("name = \"")) {
                name = trimmed.substring(8, trimmed.endsWith(",") ? trimmed.length() - 2 : trimmed.length() - 1);
            } else if (trimmed.endsWith(".png\",")) {
                String iconName = GRAPHICS_NAME_PATTERN.matcher(trimmed)
                        .results()
                        .map(matchResult -> matchResult.group(1))
                        .findFirst()
                        .orElse("__error__");
                String referencingFile = filename + ".lua:" + lineIdx;
                if (iconName.endsWith("placeholder.png\",")) {
                    iconNames.add(name + " (placeholder usage \"" + iconName + "\" at " + referencingFile + ")");
                } else if (iconName.contains("__base__")) {
                    iconNames.add(name + " (base game graphics usage \"" + iconName + "\" at " + referencingFile + ")");
                } else if (iconName.contains(MOD_BASE_REFERENCE)) {
                    verifyAssetGraphic(iconNames, name, iconName, referencingFile);
                }
            }
        }
    }

    private static void verifyAssetGraphic(List<String> iconNames, String prototype, String graphicName, String prototypeUsage) {
        Path path = Paths.get(PROJECT_DIR, graphicName.replace(MOD_BASE_REFERENCE + "/", ""));
        if (!Files.exists(path)) {
            iconNames.add(prototype + " (asset not found \"" + graphicName + "\" at " + prototypeUsage + ")");
        }
    }

    private static void loadPrototypeNames(Set<String> protoTypeNames, String filename, String prefix)
            throws IOException {
        List<Map<String, Object>> prototypes1 = parsePrototypeLua(Path.of(MOD_SUB_DIR, "prototypes", filename + ".lua"));
        var prototypes = Files.readAllLines(Path.of(MOD_SUB_DIR, "prototypes", filename + ".lua"));
        for (String prototype : prototypes) {

            String trimmed = prototype.trim();
            if (trimmed.startsWith("name = \"")) {
                String itemName =
                        trimmed.substring(8, trimmed.endsWith(",") ? trimmed.length() - 2 : trimmed.length() - 1);
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

    private static enum TokenType {
        ROOT, LIST, PAIR_KEY, PAIR_VALUE, STRING, NUMBER, BOOLEAN
    }

    private static class Token {
        public TokenType type;
        public Object data;
        public List<Token> children = new ArrayList<>();
        public int begin;

        public Token(TokenType type, int offset) {
            this.type = type;
            begin = offset;
        }

        public Object asPoJo() {
            if (type == TokenType.ROOT || type == TokenType.LIST) {
                if (isJavaMap()) {
                    Map<String, Object> result = new LinkedHashMap<>();
                    for (Token child : children) {
                        String key = (String) child.data;
                        Object value = child.children.get(0).asPoJo();
                        result.put(key, value);
                    }
                    return result;
                } else {
                    List<Object> result = new ArrayList<>();
                    for (Token child : children) {
                        result.add(child.asPoJo());
                    }
                    return result;
                }
            } else if (type == TokenType.PAIR_VALUE) {
                return children.get(0).asPoJo();
            } else if (type == TokenType.STRING || type == TokenType.NUMBER || type == TokenType.BOOLEAN) {
                return data;
            } else {
                throw new IllegalStateException("Type " + type.name() + " has no pojo serialization");
            }
        }

        private boolean isJavaMap() {
            for (Token child : children) {
                if (child.type == TokenType.PAIR_KEY) {
                    return true;
                }
                break;
            }

            return false;
        }
    }

    private static class LuaPrototypeParser {
        private Token rootToken;
        private Token currentToken;
        private Stack<Token> stack = new Stack<>();
        private final String file;

        public LuaPrototypeParser(String file, int offset) {
            this.file = file;
            Token root = new Token(TokenType.ROOT, offset);
            root.begin = offset;
            rootToken = root;
            currentToken = root;
        }

        public void parse() {
            boolean comment = false;
            for (int currentCharIndex = rootToken.begin; currentCharIndex < file.length(); currentCharIndex++) {
                char currentChar = file.charAt(currentCharIndex);

                if (comment) {
                    if (currentChar == '\r' || currentChar == '\n') {
                        comment = false;

                    }
                    continue;
                }

                if (currentToken.type == TokenType.ROOT || currentToken.type == TokenType.LIST || currentToken.type == TokenType.PAIR_KEY || currentToken.type == TokenType.PAIR_VALUE) {
                    if (Character.isWhitespace(currentChar)) {
                        continue;
                    }
                }

                if (currentToken.type != TokenType.STRING) {
                    if (currentChar == '-' && file.charAt(currentCharIndex + 1) == '-') { // comment
                        comment = true;
                        continue;
                    }
                }

                switch (currentToken.type) {
                    case ROOT -> {
                        if (currentChar == '{') { // open new list
                            addNewChild(TokenType.LIST, currentCharIndex);
                        } else if (currentChar == ')') {
                            // Part of data:extend preable. Stop
                            return;
                        } else {
                            throw new IllegalStateException("Invalid char \"" + currentChar + "\" in ROOT token");
                        }
                    }
                    case LIST -> {
                        if (currentChar == '{') { // open new list
                            addNewChild(TokenType.LIST, currentCharIndex);
                        } else if (currentChar == '}') {
                            finalizeToken();
                        } else if (currentChar == ',') {
                            // ignore
                        } else if (Character.isLetter(currentChar)) {
                            // Initializes a key value pair
                            addNewChild(TokenType.PAIR_KEY, currentCharIndex);
                        } else if (currentChar == '"') {
                            addNewChild(TokenType.STRING, currentCharIndex);
                        } else if (Character.isDigit(currentChar)) {
                            addNewChild(TokenType.NUMBER, currentCharIndex);
                        } else if (isLuaBoolean(currentChar)) {
                            addNewChild(TokenType.BOOLEAN, currentCharIndex);
                        } else {
                            throw new IllegalStateException("Invalid char \"" + currentChar + "\" in LIST token");
                        }
                    }
                    case PAIR_KEY -> {
                        if (currentChar == '=') {
                            currentToken.data = file.substring(currentToken.begin, currentCharIndex).trim();
                            addNewChild(TokenType.PAIR_VALUE, currentCharIndex + 1);
                        } else if (Character.isLetter(currentChar) || currentChar == '_') {
                            // valid char for key
                        } else {
                            throw new IllegalStateException("Invalid char \"" + currentChar + "\" in PAIR_KEY token");
                        }
                    }
                    case PAIR_VALUE -> {
                        if (currentChar == '"') {
                            addNewChild(TokenType.STRING, currentCharIndex);
                        } else if (Character.isDigit(currentChar)) {
                            addNewChild(TokenType.NUMBER, currentCharIndex);
                        } else if (currentChar == '{') {
                            addNewChild(TokenType.LIST, currentCharIndex);
                        } else if (isLuaBoolean(currentChar)) {
                            addNewChild(TokenType.BOOLEAN, currentCharIndex);
                        } else if (currentChar == ',') {
                            finalizeToken(); // finalize value and then key
                            finalizeToken();
                        } else if (currentChar == '}') {
                            finalizeToken(); // finalize value and then key
                            finalizeToken();
                            currentCharIndex--; // replay termination character
                        } else {
                            throw new IllegalStateException("Invalid char \"" + currentChar + "\" in PAIR_VALUE token");
                        }
                    }
                    case STRING -> {
                        if (currentChar == '"') {
                            currentToken.data = file.substring(currentToken.begin + 1, currentCharIndex); // Skip initial "
                            finalizeToken();
                        } else {
                            // Anything is valid in a string
                        }
                    }
                    case NUMBER -> {
                        if (Character.isDigit(currentChar) || currentChar == '.') {
                            // Valid number
                        } else {
                            String substring = file.substring(currentToken.begin, currentCharIndex);
                            boolean isFloat = substring.contains(".");
                            currentToken.data = isFloat ? Float.parseFloat(substring) : Integer.parseInt(substring);
                            finalizeToken();
                            currentCharIndex--; // replay termination char
                        }
                    }
                    case BOOLEAN -> {
                        if (isLuaBoolean(currentChar)) {
                            // Valid boolean
                        } else {
                            String substring = file.substring(currentToken.begin, currentCharIndex);
                            currentToken.data = LUA_BOOLEAN_TEXTS.getOrDefault(substring, false);
                            finalizeToken();
                            currentCharIndex--; // replay termination char
                        }
                    }
                }
            }
        }

        private void addNewChild(TokenType type, int offset) {
            Token child = new Token(type, offset);
            currentToken.children.add(child);
            stack.push(currentToken);
            currentToken = child;
        }

        private void finalizeToken() {
            currentToken = stack.pop();
        }

        private boolean isLuaBoolean(char currentChar) {
            for (char luaBooleanChar : LUA_BOOLEAN_CHARS) {
                if (luaBooleanChar == currentChar) {
                    return true;
                }
            }
            return false;
        }

        public Object getPojo() {
            return rootToken.asPoJo();
        }
    }

    private static List<Map<String, Object>> parsePrototypeLua(Path file) {
        String fileData = "";
        try {
            fileData = Files.readString(file);
        } catch (IOException e) { // will not
        }
        if (!fileData.startsWith("data:extend(")) {
            return Collections.emptyList();
        }
        LuaPrototypeParser luaPrototypeParser = new LuaPrototypeParser(fileData, 12);
        luaPrototypeParser.parse();
        //noinspection unchecked
        return (List<Map<String, Object>>) luaPrototypeParser.getPojo();
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
    private final static String ASCII_LOGO = """
                ______            _
               |  ____|          | |              (_)
               | |__  __ _   ___ | |_   ___   _ __  _   ___                  
               |  __|/ _` | / __|| __|  / _ \\ | '__|| | / _ \\                       
               | |  | (_| || (__ | |_| | (_) || |   | || (_) |
               |_|   \\__,_| \\___| \\__|  \\___/ |_|   |_| \\___/  _                     
                           /\\\\                (_)             | || |                    
                          /  \\\\    __ _  _ __  _   ___  _   _ | || |_  _   _  _ __  ___ 
                         / /\\ \\\\  / _` || '__|| | / __|| | | || || __|| | | || '__|/ _ \\
                        / ____ \\\\| (_| || |   | || (__ | |_| || || |_ | |_| || |  |  __/
                       /_/    \\_\\\\\\__, ||_|   |_| \\___| \\__,_||_| \\__| \\__,_||_|   \\___|
                                  __/ /                      Build Script Version v§BUILD_SCRIPT_VERSION§
                                 |___/
            """.replace("§BUILD_SCRIPT_VERSION§", BUILD_SCRIPT_VERSION);
}