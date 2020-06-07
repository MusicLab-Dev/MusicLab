# Mental
The key of these rules are to keep the whole codebase as **maintainable** and readable as possible.
These rules can be seen very stricts but after using them for a while you will end up reading and understanding both your code and other's members code way faster !

**Maintainability must be your main mental keyword**

# Naming
* Use 4 space for 1 tab
* Use *camelCase* for every name
* Each **class** and **enumeration** starts with an **uppercase** letter
* Everything else starts with a **lowercase** letter

# Common
* Use multiple resources pack **.qrc**, one for **each part** of your program
* Keep the code simple and **don't over-engineer** ! If a problem is becoming too complex you better find another solution

# Files / Classes
* Keep your files **small** ! (maximum is between 100 and 150 lines)
* Don't create a javascript functions when not necessary
* **Cache** heavily used calculus in properties
* You always must declare in **order**: function, properties, signals, assignments, events, children
* Separate multi-line assignments from single line ones by one empty line

# Quick recap example
```qml
// MyWidget.qml

// Qt imports
import QtQuick 2.14

// Local qml imports
import "qrc:/Common"

// Local c++ imports
import MyCppClass 1.0

Item {
  // Functions
  function doSomething() { ... }

  // Properties
  property int myProperty: 42
  property int myCachedCalcul: width * height // Put the calcul in cache to prevent re-processing it at each use
  
  // Signals
  signal mySignal
 
  // Assignments
  id: myWidget
  width: 400
  height: 300
  
  visible: { // Don't forget to add extra line between each multiline statement
    ...
  }
  
  // Events
  onVisibleChanged: ...
  onWidthChanged: ...

  onMyPropertyChanged: { // Don't forget to add extra line between each multiline statement
    ...
  }
  
  // Children
  Item { ... }
}
```
