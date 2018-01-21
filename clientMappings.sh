echo "Mapping jar"
java -XX:+UseG1GC -jar lib/SpecialSource.jar map -i "minecraft/b1_7_3_client.jar" -m "mappings/client.srg" -o "minecraft/b1_7_3_client_mapped.jar"

echo "Decompiling mapped jar"
rm -rf minecraft/src/
mkdir -p minecraft/src/
java -XX:+UseG1GC -Xmx5G -jar lib/fernflower.jar "-dgs=1" "-hdc=0" "-asc=1" "-udv=0" "-din=1" "-rbr=0" "-rsy=1" "minecraft/b1_7_3_client_mapped.jar" "minecraft/src/" | awk '$4 ~ "minecraft" {printf "Decompiling %s\r", $4}'

echo "Extracting sources"
pushd minecraft/src/
jar xf b1_7_3_client_mapped.jar
rm -rf META-INF
popd

echo "Moving source files"
# cp minecraft/src/*.java src/main/java/ # Unmapped files
cp -r minecraft/src/net/ src/main/java/

echo "Moving resource files"
cp -r minecraft/src/achievement/ src/main/resources
cp -r minecraft/src/armor/ src/main/resources
cp -r minecraft/src/art/ src/main/resources
cp -r minecraft/src/environment/ src/main/resources
cp -r minecraft/src/font/ src/main/resources
cp -r minecraft/src/gui/ src/main/resources
cp -r minecraft/src/item/ src/main/resources
cp -r minecraft/src/lang/ src/main/resources
cp -r minecraft/src/mob/ src/main/resources
cp -r minecraft/src/terrain/ src/main/resources
cp -r minecraft/src/title/ src/main/resources

echo "Done. Open the Gradle project to get started."

