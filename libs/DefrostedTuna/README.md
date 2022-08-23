# Windower 4 Support Libraries

<p align="center">
  <a href="https://github.com/DefrostedTuna/ffxi-windower-4-support-libraries/releases">
    <img src="https://img.shields.io/github/v/release/DefrostedTuna/ffxi-windower-4-support-libraries?label=Stable&sort=semver&logo=github&style=flat-square">
  </a>
</p>

This is a collection of support libraries for [Windower 4](https://www.windower.net/) that can be used for general addon development. These libraries are required for some of the addons that I've personally developed, and may also be used freely by others to develop thier own addons as well. While they do not provide any standalone functionality on their own, the included libraries are aimed at reducing the amount of code that is required within an individual addon's codebase and to keep things as [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) as possible.

## Installation

To install the libraries, simply download the latest release from [Github](https://github.com/DefrostedTuna/ffxi-windower-4-support-libraries/releases) and place the contents into your `addons/` folder within Windower's install directory as shown below.

```
windower/
├── addons/
│   └── libs/
│       └── DefrostedTuna/
│           ├── helpers.lua
│           ├── Movement.lua
│           └── README.md
├── plugins/
├── res/
├── scripts/
├── screenshots/
├── updates/
├── videos/
├── Hook.dll
├── settings.xml
└── windower.exe
```

Once the libraries are present, they will be available for use by various addons. No additional configuration is needed. To learn more about each library, see the associated documentation.

## Helpers

The helpers library is just a collection of handy helper functions used to reduce the number of lines of code required to do simple tasks.

### Usage

```lua
local helpers = require 'DefrostedTuna/helpers'

local exampleString = 'lowercase'
local exampleTable = {
    ignis = 523,
    gelus = 524,
}

helpers.table_key_exists(exampleTable, 'ignis') -- true
helpers.in_table(exampleTable, 524) -- true
helpers.ucfirst(exampleString) -- 'Lowercase'
helpers.player_is_busy() -- true or false depending on the state of the player character
helpers.player_is_sneaking() -- true or false depending on the state of the player character
```

## Movement

Movement is a library that will track the current player's movement state and determine if they player is in motion (standing, walking, running). This is set up using a singleton pattern so that the library may be included within multiple different files without creating a new instance each time. Using the library in this manner will keep from mucking up the global namespace and will reduce the number of concurrent listeners running at any given time for an addon.

### Usage

```lua
local MovementLibrary = require 'DefrostedTuna/Movement'

-- This will initialize a listener on the `prerender` event and update the player character's movement state accordingly.
movement = MovementLibrary:new()

-- Retrieve the movement state of the player character.
print(movement:getMoving()) -- true if the player character is walking/running, false if they are standing still.
```

```lua
local MovementLibrary = require 'DefrostedTuna/Movement

instanceOne = MovementLibrary:new()
instanceTwo = MovementLibrary:new()

print(instanceOne == instanceTwo) -- true
```

---

## License

Copyright © 2022, DefrostedTuna
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of Windower 4 Support Libraries nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL DEFROSTEDTUNA BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.