#!/bin/bash
# run_maven_project.sh
# A script to build and run a Maven project

# Exit immediately if any command fails
set -e

# Navigate to the directory containing the pom.xml (optional if already in root)
PROJECT_DIR="$(dirname "$0")"
cd "$PROJECT_DIR"

echo "Cleaning and building the Maven project..."
mvn clean compile

# Specify the main class here
MAIN_CLASS="org.jacoco.examples.maven.java.HelloWorld"

echo "Running the Java program..."
mvn exec:java -Dexec.mainClass="$MAIN_CLASS"

# Optional: package the project as a jar
echo "Packaging the project..."
mvn package

# Optional: archive the generated jar (target/*.jar)
echo "Archiving artifact..."
if [ -d "target" ]; then
    ls target/*.jar || echo "No jar file found to archive."
fi

echo "Pipeline execution finished successfully!"
