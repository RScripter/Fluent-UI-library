# Documentation

## Overview

The UI library is designed to help you create a simple, yet customizable, GUI in Roblox. This documentation covers the available functions and how to use them effectively.

## Getting Started

To load the UI library in a Roblox game, use the following code:

```lua
local uiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/RScripter/Fluent-UI-library/main/Source/Source.lua"))()
```

## Functions

### `uiLibrary:MakeWindow(windowInfo)`

**Description:**  
Creates a new window with a title and two frames: one for tabs and another for the main content.

**Parameters:**

- `windowInfo` (table):  
  - `Name` (string): The name/title of the window.

**Returns:**  
A table containing references to the main frame and the tabs frame.

**Example Usage:**

```lua
local window = uiLibrary:MakeWindow({Name = "My Window"})
```

### `uiLibrary:addTab(tabInfo)`

**Description:**  
Adds a new tab to the tabs frame. The tab will display its content in the main frame when clicked.

**Parameters:**

- `tabInfo` (table):  
  - `Name` (string): The name of the tab.

**Example Usage:**

```lua
uiLibrary:addTab({Name = "Tab 1"})
```

### `uiLibrary:addButton(buttonInfo)`

**Description:**  
Adds a button to the specified tab's content.

**Parameters:**

- `buttonInfo` (table):  
  - `TabName` (string): The name of the tab where the button will be added.
  - `Name` (string): The name of the button.
  - `Function` (function): The function that will be executed when the button is clicked.

**Example Usage:**

```lua
uiLibrary:addButton({
    TabName = "Tab 1",
    Name = "Click Me",
    Function = function()
        print("Button clicked!")
    end
})
```

### `uiLibrary:addLabel(labelInfo)`

**Description:**  
Adds a label to the specified tab's content.

**Parameters:**

- `labelInfo` (table):  
  - `TabName` (string): The name of the tab where the label will be added.
  - `Name` (string): The text that will be displayed on the label.

**Example Usage:**

```lua
uiLibrary:addLabel({
    TabName = "Tab 1",
    Name = "This is a label."
})
```

## Notes

- Ensure that tabs are added before adding buttons or labels to them.
- The `uiLibrary` will automatically manage the visibility of tabs and their contents based on user interaction.
- The `CanvasSize` of scrolling frames is automatically adjusted as new UI elements are added.

#Example:
```lua
-- Load the UI library from a URL
local uiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/RScripter/Fluent-UI-library/main/Source/Source.lua"))()

-- Create a window
local window = uiLibrary:MakeWindow({
    Name = "My Window"
})

-- Add a new tab
uiLibrary:addTab({
    Name = "Tab 1"
})

-- Add a button to the tab
uiLibrary:addButton({
    TabName = "Tab 1",
    Name = "Click Me",
    Function = function()
        print("Button clicked!")
    end
})

-- Add a label to the tab
uiLibrary:addLabel({
    TabName = "Tab 1",
    Name = "This is a label"
})

-- Add another tab
uiLibrary:addTab({
    Name = "Tab 2"
})

-- Add a button to the second tab
uiLibrary:addButton({
    TabName = "Tab 2",
    Name = "Another Button",
    Function = function()
        print("Another button clicked!")
    end
})
```