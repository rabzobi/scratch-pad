#!/bin/bash

module_name=opennms-webapp
version_prefix=31.0.0-SNAPSHOT
file_type=jar

module_with_version="$module_name-$version_prefix"
archive_name="$module_with_version.$file_type"

opennms_root=/root/opennms
module_path="$opennms_root/$module_name"

source_arch_path="$module_path/target/$module_with_version/WEB-INF/lib/$archive_name"
dest_arch_path="$opennms_root/target/opennms-$version_prefix/jetty-webapps/opennms/WEB-INF/lib/$archive_name"
webapp_full_path="$opennms_root/opennms-assemblies/webapp-full/target/war/work/org.opennms/opennms-webapp/WEB-INF/lib/$archive_name"

echo "--> Building $module_path"
cd "$module_path" || exit 1
$opennms_root/maven/bin/mvn clean install -DskipTests=true || exit 1

ls -la $source_arch_path || exit 1
ls -la $dest_arch_path || exit 1

echo "--> Copying $source_arch_path to $dest_arch_path..."
cp -r $source_arch_path $dest_arch_path || exit 1
cp -r $source_arch_path $webapp_full_path || exit 1

echo "--> Printing Copied file information..."
ls -la $dest_arch_path || exit 1
ls -la $webapp_full_path || exit 1

echo "--> Restarting OpenNMS..."
kill -9 $(ps aux | grep opennms | grep -v grep | awk '{print $2}')
eval "$opennms_root/target/opennms-$version_prefix/bin/opennms -t start" || exit 1;

until $(curl --output /dev/null --silent --head --fail http://localhost:8980/opennms); do
    printf '.'
    sleep 5
done

sleep 5
echo "Done"
