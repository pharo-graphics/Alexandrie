| repoPath |

Stdio stdout << 'ciPreLoading.st - Adding $GITHUB_WORKSPACE directory to Iceberg: '.
repoPath := Smalltalk os environment
	at: 'GITHUB_WORKSPACE'
	ifAbsent: [
		Stdio stdout nextPutAll: 'NOT DEFINED, WRONG'; lf.
		^ self ].
Stdio stdout print: repoPath; lf.
LibC runCommand: 'ls -lah ', repoPath.

(IceRepositoryCreator new
  location: repoPath asFileReference;
  createRepository) register.
