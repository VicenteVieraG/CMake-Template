#!/usr/bin/env nu

def main [] {
    print "Framework's Command Line Tool";
}

def "main addModule" [module: string shared: bool = false private: bool = false] {
    let src_dir: string = (['src' $module] | path join);
    let includes_dir: string = (['includes' $module] | path join);
    let parent_src_CMakeLists: string = (['src' 'CMakeLists.txt'] | path join);
    let parent_includes_CMakeLists: string = (['includes' 'CMakeLists.txt'] | path join);
    let src_CMakeList: string = ([$src_dir 'CMakeLists.txt'] | path join);
    let includes_CMakeLists: string = ([$includes_dir 'CMakeLists.txt'] | path join);
    let library_type: string = if $shared { 'SHARED' } else { 'STATIC' };
    let library_link_type: string = if $private { 'PRIVATE' } else { 'PUBLIC' };
    let files: list<string> = [
        ([$src_dir $"($module).cpp"] | path join)
        $src_CMakeList
        ([$includes_dir $"($module).hpp"] | path join)
        $includes_CMakeLists
    ];
    let modified_files: list<string> = [
        $parent_src_CMakeLists
        $parent_includes_CMakeLists
    ];
    let add_library_statement = $"add_library\(($module) ($library_type) ($module).cpp)";
    let target_include_directories_statement = $"target_include_directories\(($module) ($library_link_type) ${CMAKE_CURRENT_SOURCE_DIR})";

    mkdir $src_dir $includes_dir;
    touch ...$files;

    $add_library_statement | save --append $src_CMakeList;
    $target_include_directories_statement | save --append $includes_CMakeLists;

    open $parent_src_CMakeLists
        | lines --skip-empty
        | str trim
        | append $"add_subdirectory\(($module))"
        | str join "\n"
        | $"($in)\n"
        | save --force $parent_src_CMakeLists
        ;
    open $parent_includes_CMakeLists
        | lines --skip-empty
        | str trim
        | append $"add_subdirectory\(($module))"
        | str join "\n"
        | $"($in)\n"
        | save --force $parent_includes_CMakeLists
        ;

    print $"(ansi green)Added module: (ansi green_bold)($module)(ansi reset)";
    print 'Created files:';
    print (
        $files | each { |file|
            {
                files: ($file | path basename)
                path: ($file | path dirname)
            }
        } | table;
    );
    print 'Modified files:';
    print (
        $modified_files | each { |file|
            {
                files: ($file | path basename)
                path: ($file | path dirname)
            }
        } | table;
    );
}

def "main linkModule" [linkModule: string targetModule: string private: bool = false] {
    print uwu;
}

def "main add gitSubmodule" [name: string gitURL: string] {
    git submodule add --force --name $name $gitURL external/($name);
}

def "main remove gitSubmodule" [name: string] {
    git submodule deinit --force external/($name);
    git rm --force external/($name);
    rm --recursive --force .git/modules/($name);
}
