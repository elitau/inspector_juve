# Inspector Juve - Testability analysis for Ruby

Inspector Juve is static code Analysis Tool for Ruby code to detect testability flaws. Testability flaws are in most cases the result of misregarding object orientation and design principles like SOLID. Also dependencies of some piece of code adds testing effort and thus reduces testability. Futhermore plays the obeservability und controllability a big role for testability of software.

## Installation and prerequisites
Inspector Juve works with Ruby 2.0.0 and above and utilizes Bundler for dependency management.
To setup Inspector Juve, navigate into the juve's root folder and run bundler install to download all dependencies:
$ bundler install

## Usage
Inspector Juve comes with simple command line tool based on Thor [1]. On the first run it runs YARD to create the object database, which is needed for Juve's localization of weakpoints.
Navigate to juve's root folder within your Terminal and execute the command line with a path to the code that should be analyzed:
$ thor weakpoints:search PATH_TO_RUBY_CODE

## Testability
[ISO SQuaRE 25010]: [Testability is] the **ease** with which test criteria can be established for a system or component and **tests can be performed** to determine whether those criteria have been met.

Inspector Juve utilizes YARD, a documentation tool for ruby. The detection of Testability flaws itself is delegated to Juve *Localizers*.

## Current Localizers

### MethodMissing methods not calling super or raising NoMethodError
A custom method_missing should call super or raise a NoMethodError manually. Otherwise that code can be trapped in an infinite loop causing StackLevelTooDeep Exceptions. Another problem may arise due to swallowing to much messages.

### Modules accessing foreign instance variables
In Ruby modules are mostly used to reuse code in multiple places but not for redifining behaviour. Thus it is not appropriate to access instance variables of the class the module got mixed in.

### Overwritten methods not calling super of base class
A redfined method in a subclass should be calling the implementation if its base class.


## Specialities for Ruby
Inspector Juve respects Ruby's *dynamic typing* by pointing out testability problem regarding this language feature. Dynamic typing also results in higher difficulty during static code analysis.

## Links
[1] Thor: http://whatisthor.com
