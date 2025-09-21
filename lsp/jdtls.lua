return {
    cmd = { 'nix', 'develop', '--command', 'jdtls' },
    filetypes = { 'java' },
    root_markers = { 'build.xml', 'pom.xml', 'settings.gradle', 'build.gradle', '.git' },
    init_options = {
        settings = {
            java = {
                imports = {
                    gradle = {
                        enabled = true,
                        wrapper = {
                            enabled = true,
                            checksums = {
                                {
                                    sha256 = '7d3a4ac4de1c32b59bc6a4eb8ecb8e612ccd0cf1ae1e99f66902da64df296172',
                                    allowed = true,
                                },
                            },
                        },
                    },
                },
            },
        },
    },
}