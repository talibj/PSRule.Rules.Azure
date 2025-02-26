---
author: BernieWhite
---

# Validating locally

While preparing infrastructure code artifacts, Azure resources can be validated locally.
PSRule for Azure can be installed locally on MacOS, Linux, and Windows for local validation.

!!! Tip
    If you haven't already, follow the instructions on [Installing locally][1] before continuing.
    If analyzing Azure resources from Bicep source files, complete [Setup Bicep][2].

  [1]: install-instructions.md#installinglocally
  [2]: setup/setup-bicep.md

## With Visual Studio Code

[:octicons-download-24: Extension][3]

An extension for Visual Studio Code is available for an integrated experience using PSRule for Azure.
The Visual Studio Code extension includes a built-in `PSRule: Run analysis` task.

<p align="center">
  <img src="https://raw.githubusercontent.com/microsoft/PSRule-vscode/main/docs/images/tasks-provider.png" alt="Built-in tasks shown in task list" />
</p>

To learn about tasks in Visual Studio Code see [Integrate with External Tools via Tasks][4].

To use PSRule for Azure with the built-in `PSRule: Run analysis` task, insert the following into `.vscode/tasks.json`.

```json
{
    "type": "PSRule",
    "problemMatcher": [
        "$PSRule"
    ],
    "label": "PSRule: Run analysis",
    "modules": [
        "PSRule.Rules.Azure"
    ],
    "presentation": {
        "clear": true,
        "panel": "dedicated"
    }
}
```

!!! Example
    A complete `.vscode/tasks.json` might look like the following:

    ```json
    {
        "version": "2.0.0",
        "tasks": [
            {
                "type": "PSRule",
                "problemMatcher": [
                    "$PSRule"
                ],
                "label": "PSRule: Run analysis",
                "modules": [
                    "PSRule.Rules.Azure"
                ],
                "presentation": {
                    "clear": true,
                    "panel": "dedicated"
                }
            }
        ]
    }
    ```

  [3]: https://marketplace.visualstudio.com/items?itemName=bewhite.psrule-vscode
  [4]: https://code.visualstudio.com/docs/editor/tasks
