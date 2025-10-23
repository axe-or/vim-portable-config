#!/usr/bin/env sh
distRoot="mf-vim"

PKGS="
	tpope/vim-commentary
	tpope/vim-repeat
	tpope/vim-surround
	tpope/vim-fugitive
	kien/ctrlp.vim
	junegunn/vim-easy-align
	marcs-feh/vim-compile
	marcs-feh/vim-odin
	marcs-feh/vim-udark
"
set -eu

FetchPlugins(){
	mkdir -p plugins
	cd plugins

	for pkg in $PKGS; do
		pkg="$(echo $pkg | sed -E 's/\s*//g')"
		[ -z "$pkg" ] || {
			pkgDir="$(basename "$pkg")"
			[ -d "$pkgDir" ] || {
				echo "    Downloading $pkg ..."
				git clone --quiet --depth=1 "https://github.com/$pkg"
			}
			cd "$pkgDir"
			git pull --quiet
			cd ..
		} &
	done

	wait
	cd ..
}

UnpackPlugins(){
	rootFolder="$distRoot/start"

	mkdir -p "$rootFolder"
	for pkg in $PKGS; do
		pkg="$(echo $pkg | sed -E 's/\s*//g')"
		[ -z "$pkg" ] || {
			pkgDir="$(basename "$pkg")"
			anchor="$(pwd)"

			mkdir -p "$distRoot/start/$pkgDir"
			cd "plugins/$pkgDir"
			git archive HEAD --format=zip > "$anchor/$distRoot/start/$pkgDir/plugin.zip"
			cd "$anchor/$distRoot/start/$pkgDir"
			unzip -q plugin.zip
		} &
	done
	wait
}

CleanFiles(){
	cleanup="$(find $distRoot \
		-name '*.zip' -o \
		-name '*.gif' -o \
		-name '*.png' -o \
		-name '*.jpg' -o \
		-name '*.webp' -o \
		-name '*.yml' -o \
		-name '*.vader' -o \
		-name '*.markdown' -o \
		-name 'CONTRIBUTING.*' -o \
		-name '.github'
	)"

	rm -rf $cleanup
}


rm -rf "$distRoot" vim-config.zip .vimrc .vim

echo 'Downloading plugins with git'
FetchPlugins

echo 'Unpacking'
UnpackPlugins

echo 'Cleaning files'
CleanFiles

mkdir -p .vim/pack .vim/colors .vim/after

cp vimrc .vimrc &
cp -r "$distRoot" .vim/pack &
cp -r syntax .vim/after &
wait

echo 'Generating Vim tarball'
tar czf vim-config.tgz .vimrc .vim

echo 'Generating Neovim tarball'
mv .vim nvim
mv .vimrc nvim/init.vim
tar czf nvim-config.tgz nvim

echo 'Generating base64 encoded versions'
base64 vim-config.tgz > vim-config.tgz.txt
base64 nvim-config.tgz > nvim-config.tgz.txt

rm -rf nvim "$distRoot"
