How to use the parser
=====================

Intro
-----

The parser is a tool to have pseudocode inside of text output in order to avoid to much mixing of text output with AS3-code.

### Examples

For example, instead of writing:
```as3
outputText("He sticks his cock into your " + player.vaginaDescript() + ".");
```
you could just write:
```as3
outputText("He sticks his cock into your [cunt].");
```

Another example, but with a conditional:

Without using the parser:
```as3
outputText("He sticks his cock into your ");
if (player.hasVagina())
	outputText(player.vaginaDescript());
else
	outputText(player.buttDescript());
outputText(".");
```
With the parser:
```as3
outputText("He sticks his cock into your [if (hasVagina)[cunt]|[butt]].");
```

Single arg tags
---------------

Single arg tags don't have a param and are directly replaced with the corresponding text.

### Table

| Tag           | Description                                  | Example                                                                                       |
|---------------|----------------------------------------------|-----------------------------------------------------------------------------------------------|
| `[armor]`     | The actual armor the player is wearing       | `You take off your [armor].`<br> You take off your **goo armor**.                             |
| `[armorname]` | Alias of `[armor]`                           |                                                                                               |
| `[ass]`       | Show a short description of the players ass. | `He strokes your [butt].`<br> He strokes your **well toned rear**.                            |
| `[asshole]`   | A short description of the players asshole   | `He puts his cock into your [asshole].`<br> He puts his cock into your **drooling backdoor**. |

Double arg tags
---------------

Placeholder

NPC tags
--------

For NPCs whose gender may change.

Parser conditionals and tags
----------------------------

Placeholder
