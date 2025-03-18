# Regression Testing

The project counts with test packages that pixel-compare the actual output of the render with PNGs that were previously exported. 
If any pixel doesn't match with the expected output, the test fails. Browse subclasses of `AePixelMatchTest` to see them: 
* `AeCairoRenderTest`
* `AeCanvasTest`
* `AeCairoConvertTest`
* `AeCairoExamplesRenderTest`
* `AeCairoMigratedRenderTest`
* `AeCairoRecordingSurfaceRenderTest`
Such tests must be run in the Test Runner, because there is some hacky part that is not compatible with Calypso (the class browser).

**Where are the PNGs?**

Each test class defines methods that draw and return a AeCairoSurface or Form, and has an associated PNG (the expected result). Those PNGs are in the 'tests/' directory of this repo. A tricky part is how to locate the expected PNGs in the filesystem. To do it, the `AeFilesystemResources` will look into the registered Iceberg repositories for one named 'Alexandrie' (case-insensitive). This means that the test will ERROR if the repository is not registered at Iceberg. Normally the repository is registered after Metacello load. 

CI jobs (smalltalk-ci via '.ci.ston') execute a pre-install script (located in the 'scripts/' directory) that registers the repository explicitly in Iceberg.

**Steps to debug CI locally:**

1. cd to some tmp directory
2. `git clone https://github.com/pharo-graphics/Alexandrie.git && export GITHUB_WORKSPACE="$(pwd)/Alexandrie" && ~/d/pharo/smalltalkCI/bin/smalltalkci -s Pharo64-11 Alexandrie/.ci.ston`
