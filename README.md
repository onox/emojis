[![Build status](https://github.com/onox/emojis/actions/workflows/build.yaml/badge.svg)](https://github.com/onox/emojis/actions/workflows/build.yaml)
[![Alire json](https://img.shields.io/endpoint?url=https://alire.ada.dev/badges/json.json)](https://alire.ada.dev/crates/emojis.html)
[![License](https://img.shields.io/github/license/onox/emojis.svg?color=blue)](https://github.com/onox/emojis/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/github/release/onox/emojis.svg)](https://github.com/onox/emojis/releases/latest)
[![IRC](https://img.shields.io/badge/IRC-%23ada%20on%20libera.chat-orange.svg)](https://libera.chat)
[![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.svg)](https://gitter.im/ada-lang/Lobby)

# emojis

An Ada 2012 library to replace names between colons with emojis.

## Usage

```ada
Ada.Text_IO.Put_Line (Emojis.Replace ("Ada is :heart_eyes: <3"));
```

This will print to the terminal:

```
Ada is 😍 🧡
```

Some of the text emojis like `:o` and `:p` are a prefix of certain labels.
Use the `Completions` parameter to avoid the last one being replaced if the
text is used in some input field (when the user is pressing the Tab key to
cycle through all the labels):

```ada
Ada.Text_IO.Put_Line
  (Emojis.Replace ("XD :o :p", Completions => Emojis.Lower_Case_Text_Emojis));
```

Prints:

```
😆 😮 :p
```

The function `Labels` returns a list of all the labels.

## Dependencies

In order to build the library, you need to have:

 * An Ada 2012 compiler

 * [Alire][url-alire]

## Installing dependencies on Ubuntu

Install the dependencies using apt:

```sh
$ sudo apt install gnat gprbuild
```

and then install Alire.

## Using the library

Use the library in your crates as follows:

```
$ alr with emojis
```

## Contributing

Read the [contributing guidelines][url-contributing] if you want to add
a bugfix or an improvement.

## License

The Ada code and unit tests are licensed under the [Apache License 2.0][url-apache].
The first line of each Ada file should contain an SPDX license identifier tag that
refers to this license:

    SPDX-License-Identifier: Apache-2.0

  [url-alire]: https://alire.ada.dev/
  [url-apache]: https://opensource.org/licenses/Apache-2.0
  [url-contributing]: /CONTRIBUTING.md
