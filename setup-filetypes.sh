#!/usr/bin/env bash

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

APP="${HOME}/Applications/Open in Neovim.app"
XCODE="/Applications/Xcode.app"
XCODE_EXTENSIONS=(swift m mm xcscheme)
LSREGISTER="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister"

echo "Setting up file associations..."

EXTENSIONS=($(grep -Ev '^(#|$)' "${DOTFILES_DIR}/filetypes/extensions"))

# macOS can only default to an app bundle, so wrap filetypes/open-file in one
mkdir -p "$(dirname "$APP")"
rm -rf "$APP"
osacompile -o "$APP" <<EOF
on open theFiles
    set fileArgs to ""
    repeat with theFile in theFiles
        set fileArgs to fileArgs & " " & quoted form of POSIX path of theFile
    end repeat
    do shell script quoted form of "${DOTFILES_DIR}/filetypes/open-file" & fileArgs
end open
EOF

JSON_EXTENSIONS="$(printf '"%s",' "${EXTENSIONS[@]}")"
PLIST="${APP}/Contents/Info.plist"
plutil -replace CFBundleIdentifier -string "com.yegeun.open-in-nvim" "$PLIST"
plutil -replace LSUIElement -bool true "$PLIST"
plutil -replace CFBundleDocumentTypes -json "[{
    \"CFBundleTypeName\": \"Text or source file\",
    \"CFBundleTypeRole\": \"Editor\",
    \"LSHandlerRank\": \"Alternate\",
    \"CFBundleTypeExtensions\": [${JSON_EXTENSIONS%,}]
}]" "$PLIST"

# Editing Info.plist invalidates the signature osacompile applied
codesign --force --sign - "$APP" 2> /dev/null
"$LSREGISTER" -f "$APP"
echo "  ✓ Built ${APP}"

set_defaults() {
    if ! swift "${DOTFILES_DIR}/filetypes/set-defaults.swift" "$@"; then
        echo "  ⚠️  Some file types were not set"
        exit 1
    fi
}

set_defaults "$APP" "${EXTENSIONS[@]}"
echo "  ✓ Set default app for ${#EXTENSIONS[@]} file types"

# Swift and Objective-C belong to Xcode even outside a project
if [ -d "$XCODE" ]; then
    set_defaults "$XCODE" "${XCODE_EXTENSIONS[@]}"
    echo "  ✓ Set Xcode as default for ${#XCODE_EXTENSIONS[@]} file types"
fi

echo "✓ File associations setup complete!"
