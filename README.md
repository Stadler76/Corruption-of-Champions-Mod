Corruption-of-Champions-Mod
===========================
[![Build Status](https://travis-ci.org/Kitteh6660/Corruption-of-Champions-Mod.svg?branch=master)](https://travis-ci.org/Kitteh6660/Corruption-of-Champions-Mod)
[![Sonarcloud code analysis](https://sonarcloud.io/api/project_badges/measure?project=org.github.Kitteh6660%3ACorruption-of-Champions-Mod&metric=alert_status)](https://sonarcloud.io/dashboard?id=org.github.Kitteh6660%3ACorruption-of-Champions-Mod)

NOTE: CONTAINS MATURE CONTENT. ADULTS ONLY

CoC Mod source from Kitteh6660. Original game by Fenoxo.  
Modifications by everyone at:  
https://github.com/Kitteh6660/Corruption-of-Champions-Mod/graphs/contributors

Everything in original game is copyright Fenoxo (fenoxo.com).

Check out the wiki for information and the FAQ.

**Playable releases can be found in the Releases tab.**  
**Android Releases:** https://github.com/Hexxah/CoC-MOD-Android-Build  

**Discord Server:** https://discord.gg/R25MZEx

# Building with ant
## Prerequisites
- Java JRE installed
- Ant installed
- Environment variable FLEX_HOME set to the flex SDK path

## Building
To build run:

`ant`

If you want to skip the tests (not recommended):

`ant release` or `ant debug`

To list the ant targets:

`ant -p`

## Testing
To run all tests:

`ant test`

To run a single test case or suite:

`ant test-single -Dtestclass=fqn.of.class`

example:

`ant test-single -Dtestclass=classes.Items.MutationsTest`

This allows for quick testing or debugging of classes without running all tests.
