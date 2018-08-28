# Hammerspoon Window Management

## Introduction

This repository contains my [Hammerspoon](https://www.hammerspoon.org/) configuration, which I basically use for Window management on macOS. I have three configurations:

* Office stationary - When I'm on my desk at work
* Office mobile - When I'm in meetings and such
* Homeoffice - When I'm on my desk at home

I have different window placements over the available screens and spaces on each of these configurations.

This repository is a backup location for me and may be a reference for others who achieve the same thing.

## Prerequisites

* [hs._asm.undocumented.spaces](https://github.com/asmagill/hs._asm.undocumented.spaces)

## Code structure

Each configuration lies in its own function. First, it grabs the ids for the available spaces and then it scans for available screens. After that, it uses the `positionApp` function to position the windows of my applications.

## Finding the right spaces

Somehow macOS keeps shuffling space ids around with no real reason and there is currently no function to get the visible name you can configure in Mission Control. This makes it hard to identify the right space.

So I'm using a dirty workaround here: I'm using the default Shortcuts to visit spaces to switch to all spaces (I use six spaces) and note the corresponding space id.

## Finding the right screen

Also, screens are quite difficult to identify. I now use the virtual position of the screen to identify the screen I want.