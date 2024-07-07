
Script to load the full project (`master` branch), do:

```smalltalk
Metacello new
        baseline: 'Alexandrie';
        repository: 'github://pharo-graphics/Alexandrie/src';
        load.
```

This is an example of more customized load, with:
- `dev` branch and 
- `ffi-minimal` Baseline group

```smalltalk
Metacello new
        baseline: 'Alexandrie';
        repository: 'github://pharo-graphics/Alexandrie:dev/src';
        load: 'ffi-minimal'.
```
