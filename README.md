# wow-data

wow-data is a Ruby library aimed at making it easy to parse data files related to World of Warcraft.
Currently, rudimentary support is present for DBC, DB2, ADT, and packet capture files.

## Packet Captures

wow-data supports parsing a limited number of opcodes for a limited number of World of Warcraft builds. Support is expanding all the time, but don't be surprised to find issues parsing any given capture file.

### Exporting Packet Captures to JSON

In the event you'd prefer working with your packet capture in a different language or tool, you can use the included export_json.rb tool to dump a supported capture file to JSON.

To get information on usage, in the root of the ```wow-data``` repo, run:
```
ruby tools/export_json.rb -h
```

To output packets as JSON, in the root of the ```wow-data``` repo, run:
```
ruby tools/export_json.rb <capture_path>
```

See the full help output for information on formatting and filtering options.

## Acknowledgements

Thanks to everyone in the TC community; in particular @DDuarte and @Carbenium for their work on WPP, the source for a lot of the logic used in ```wow-data```'s capture parsing packet structure definitions.
