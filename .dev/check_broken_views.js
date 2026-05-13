const fs = require("fs");
const path = require("path");

function checkDirectory(dirPath) {
  const items = fs.readdirSync(dirPath, { withFileTypes: true });

  for (const item of items) {
    const fullPath = path.join(dirPath, item.name);

    if (item.isDirectory()) {
      checkDirectory(fullPath);
    } else if (item.isFile() && item.name.endsWith(".dart")) {
      const content = fs.readFileSync(fullPath, "utf8");
      const lines = content.split("\n");

      if (lines.length < 10) {
        console.log(
          `[<10 length,${lines.length}] File ${fullPath} is broken, it does not end with '}'.`,
        );
        console.log(content);
        process.exit(0);
      }

      // Check if last line ends with "}"
      if (lines[lines.length - 1].trim() !== "}") {
        // Check if second to last line ends with "}"
        if (lines.length > 1 && !lines[lines.length - 2].trim().endsWith("}")) {
          if (
            lines.length > 1 &&
            !lines[lines.length - 3].trim().endsWith("}")
          ) {
            console.log(
              `File ${fullPath} is broken, it does not end with '}'.`,
            );
            process.exit(0);
          }
        }
      }
    }
  }
}

function main() {
  const presentationDir = path.join("lib", "presentation");

  if (!fs.existsSync(presentationDir)) {
    console.log(`Directory ${presentationDir} does not exist.`);
    process.exit(1);
  }

  checkDirectory(presentationDir);
  console.log("Check completed.");
}

main();
