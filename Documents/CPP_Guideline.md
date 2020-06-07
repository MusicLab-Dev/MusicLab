# Mental
The key of these rules are to keep the whole codebase as **explicit** and readable as possible.
These rules can be seen very stricts but after using them for a while you will end up reading and understanding both your code and other's members code way faster !

**Explicit must be your main mental keyword**

# Global naming
* Use 4 space for 1 tab
* You must use **camelCase** notation for everything, please watch below the uppercase rule of each function
* All files must starts with an **uppercase**
* All header files must have the **.hpp** extension, sources the **.cpp** and header extensions the **.ipp**
* Any kind of **function** will always contains a **verb** in its name
* A **static** function always starts with an **uppercase**, a **member** with a **lowercase**
* A **public or scoped variable** always starts with a **lowercase**, a **private** will have **_** in top of it
* A **public static member variable** always starts with an **uppercase**, a **private** will have **_** in top of it

# Common
* When including something to a header or source file, they should be separated of one line in this **order: system, thrid-party, local**
* Use **constexpr** as much as possible (constant variable declaration, functions...)
* All enumerations must be **class** or you better have serious justification
* All function that can't throw exception must be **noexcept**
* All member function that doesn't modify the object must be **const**
* Everything that is not cheaply copyable (with a single copy instruction of less than 8 bytes) should be passed as **const reference**
* Everything you pass by parameter and don't modify must be **const** referenced (even copies)
* Your good default choice for any container is **std::vector**, anything else will require a serious justification
* If you want to use **linked-lists**, you better prepare a **very very detailled justification**
* Don't ever use **new** or **delete** without a strong and detailled justification

# Header
* Only 1 header file per class (exception are for small nested classes or [POD](https://en.wikipedia.org/wiki/Passive_data_structure) structures that can share its parent header)
* Avoid **all** unecessary includes that can be moved in source file
* No function larger than 2 or (max 3) lines in a header file, if your class is designed header-only, use the **.ipp** extension to store implementation details
* *using namespace XYZ* is **forbiden** in any header file at global scope
* All headers must be **commented** in a doxygen-able format, it include **functions**, **classes**, **enums**
* Use the **default** constructor / destructor / assignment everytime it is possible in your class design (if all are default you can just remove them all, they'll be defaulted)
* A namespace must **not** contain any implementation, classes must be forwarded and implemented outside of the namespace declaration
* You **must** use **[[nodiscard]]** for any function's return that shouldn't be discarded

# Sources
* Only 1 source file per class
* *using namespace XYZ* is allowed only if the class implemented is **in that namespace**

# Quick recap example class
```C++
// ------------ MyWidget.hpp ------------

#include <cinttype> // System includes

#include <LibDraw/Drawer.hpp> // Third party

#include "Other.hpp" // Local

namespace My
{
  class Widget; // Forward class declaration to not implement it on the namespace !
  
  [[nodiscard]] constexpr float MultiplyBy42(float x) noexcept { return 42 * x; } // Constexpr whenever possible
}

/**
 * @brief Widget class, responsible of doing things
 */
class My::Widget
{
public:
  /** @brief All states that widget can hold */
  enum class State { ... }; // Use class enums to prevent conflicts

  /** @brief My super static public variable */
  static constexpr std::int32_t MyStaticPublicVar = 42; // Use constexpr whenever possible

  /** @brief Construct the widget with a given data */
  Widget(const std::int32_t data) noexcept : _data(data) {} // Use const when not modifying the argument, even on copy

  /** @brief Copy constructor is not allowed */
  Widget(const Widget &) = delete; // Delete unsupported operators to make it explicit
  
  /** @brief Move constructor */
  Widget(Widget &&other) noexcept = default; // Default supported operators to make it painless for you
  
  /** @brief Destruct the instance and release drawer memory */
  ~Widget(void) = default;

  /** @brief Will draw current in configuration */
  void draw(void);
  
  /** @brief Will draw a given shape */
  template<typename Shape>
  void drawShape(void);
   
  /** @brief Get current data value */
  [[nodiscard]] std::int32_t getData(void) const noexcept { return _data; } // Don't forget nodiscard, const and noexcept !

private:
  /** @brief My super static private variable */
  static constexpr std::int32_t _MyStaticPrivateVar = 43;
  
  Drawer _drawer;
  std::int32_t _data { 0 }; // Don't let uninitialized base type
};

#include "MyWidget.ipp" // Don't forget to include header extension !

// ------------ MyWidget.cpp ------------

#include "MyWidget.hpp"

using namespace My; // You can use it in source file

void Widget::draw(void)
{
  ...
}

// ------------ MyWidget.ipp ------------ 

// It isn't necessary ot include "MyWidget.hpp" here
template<typename Shape>
void drawShape(void)
{
  ...
}
```
