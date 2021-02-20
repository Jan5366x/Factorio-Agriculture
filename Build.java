import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Objects;

/**
 * Build Factorio Agriculture Mod - Zip File
 * java single file execution - java 15
 */
public class Build {
    private final static String PROJECT_DIR = "Factorio-Agriculture";
    private final static String MOD_SUB_DIR = "Factorio-Agriculture";
    private final static String BUILD_DIR = "build";

    private final static String ERROR_BUILD_DIR = """
            Build directory problem!

            Build dir don't met the expected folder structure!
            """;

    public static void main(String[] args) throws Exception {
        prepareBuildFolder();
        copyFiles();
        renameAndZip();
    }

    private static void prepareBuildFolder() throws Exception {
        var directory = new File(File.separator + BUILD_DIR);
        if (!directory.exists())
            directory.mkdir();

        // sanity check
        if (!directory.toString().contains(PROJECT_DIR + File.separator + MOD_SUB_DIR + File.separator + BUILD_DIR))
            throw new IOException(ERROR_BUILD_DIR);

        purgeDirectory(directory);
    }

    private static void copyFiles() throws Exception  {
        // TODO implement
    }

    private static void renameAndZip() throws Exception  {
        var version = fetchModVersionString();
        // TODO implement
    }

    private static String fetchModVersionString() throws Exception {
        throw new Exception("Not implemented!");
    }

    public static void copyDirectory(String sourceDirectoryLocation, String destinationDirectoryLocation)
            throws IOException {
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
}