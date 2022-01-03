if command -v flatpak > /dev/null
then
    # Get a list of flatpak applications in the reverse domain name format
    readarray -t ids < <(flatpak list --app --columns=application)
    for id in "${ids[@]}"
    do
        # Take everything past the last dot (the name)
        name="${id##*.}"
        # Make it lowercase to approximate binary name
        binary="${name,,}"

        # If there is not already a command at that name
        if ! command -v "${binary}" > /dev/null
        then
            # Create an alias that runs the flatpak
            alias "$binary=flatpak run \"$id\""
        fi
    done
fi
