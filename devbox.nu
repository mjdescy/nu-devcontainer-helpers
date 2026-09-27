# Return the name of the devcontainer associated with the current folder.
# The association is read from the container label written by the
# devcontainer tooling. If no container matches, the function returns nothing.
def devbox-id [] {
    # Use the canonical absolute path so it matches the label consistently.
    let folder = (pwd | path expand)

    # Inspect running containers as structured JSON rather than parsing text.
    podman ps --format json | from json
    | where {|c|
        let labels = ($c.Labels? | default {})
        # Check that the label exists before reading it from the label record.
        let has_folder_label = ($labels | columns | any {|k| $k == "devcontainer.local_folder"})
        if $has_folder_label {
            let container_folder = ($labels | get "devcontainer.local_folder" | path expand)
            $folder == $container_folder or ($folder | str starts-with ($container_folder + "/"))
        } else {
            false
        }
    }
    # Names is a list in Podman's JSON output; return only its first entry.
    | each {|c| $c.Names.0} | first
}

# Enter (execute bash in) the devcontainer associated with the current folder.
def devbox-enter [] {
    # Get the name of the devcontainer associated with the current folder.
    let devbox = devbox-id
    # Check that a devcontainer name was returned.
    if ($devbox | is-empty) {
        print "No running devcontainer found for the current folder"
        return
    }
    # Enter the devcontainer using podman.
    podman exec -it --user vscode $devbox bash
}
