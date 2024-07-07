Welcome to the Alexandrie wiki!

To load `master` branch:

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

---

🚨 This wiki doesn't end here 🚨 See more pages on the Side Bar 👉 👉 👉

