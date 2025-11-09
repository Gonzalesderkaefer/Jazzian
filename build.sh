#!/usr/bin/sh


if command -v cargo &> /dev/null; then
    if command -v rustup &> /dev/null; then
        # Add the target
        rustup target add x86_64-unknown-linux-musl

        # Build
        cargo build --release --target=x86_64-unknown-linux-musl

        # Move the file to the root
        mv -f target/x86_64-unknown-linux-musl/release/jazzy .
    else
        printf "rustup not found\n"
        exit 1
    fi
else
    printf "Cargo not found\n"
    exit 1
fi


