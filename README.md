# A Dark Fairytale
HKU Graduation Project repository.

## Cloning this repository using [Fork](https://git-fork.com/)
Go to File > Clone. In github, click Code (green button topright), make sure HTTPS is selected and clone the url, then paste it in Fork. Select a suitable folder and click clone.

## Setting up Scene Merging
Scene merging is very important because otherwise things suck butt. NOTE: this won't solve all problems forever, but it may help prevent simple merge conflicts that can be resolved automatically. **It is still good practice to let your team know when you're making changes to a scene.**

** Create a `.gitconfig` file in the cloned repository and add the following:

```
[merge]
tool = unityyamlmerge

[mergetool "unityyamlmerge"]
trustExitCode = false
cmd = '<path to UnityYAMLMerge>' merge -p "$BASE" "$REMOTE" "$LOCAL" "$MERGED"
```

Assuming Unity is installed via UnityHub, the path to UnityYAMLMerge will be:

**on Windows:**
```
C:\Program Files\Unity\Hub\Editor\<Unity Version>\Editor\Data\Tools\UnityYAMLMerge.exe
```

**on Mac OSX:**
```
/Applications/Unity/Unity.app/Contents/Tools/UnityYAMLMerge
```

Replace <path to UnityYAMLMerge> with the correct path. **Make sure the path is correct.** If you can't find the UnityYAMLMerge program anywhere, contact me and we'll resolve the issue.

Now you should have UnityYAMLMerge installed for resolving scene (amongst others) merge conflicts.
