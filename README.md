# Alexandrie

A Cairo canvas for [Bloc](https://github.com/pharo-graphics/Bloc).
It focuses on using Cairo without waste: just call the API in smart way.


## Install

Load the baseline in a Pharo 11:

```smalltalk
EpMonitor disableDuring: [
  Author useAuthor: 'Load' during: [
    [	Metacello new
        baseline: 'Alexandrie';
        repository: 'github://pharo-graphics/Alexandrie:master/src';
        onConflictUseIncoming;
        ignoreImage;
        load.
    ]	on: MCMergeOrLoadWarning
      do: [ :warning | warning load ] ] ]
```
