<?php

declare(strict_types=1);

/**
 * Copyright (c) 2019-2026 Andreas Möller
 *
 * For the full copyright and license information, please view
 * the LICENSE.md file that was distributed with this source code.
 *
 * @see https://github.com/ergebnis/.github
 */

/**
 * Generates the list and the sections of composite actions in README.md from the README.md of each composite action.
 *
 * The section of a composite action contains the text between the title and the first code block of its README.md.
 */
(static function (): void {
    $root = \dirname(__DIR__);
    $readmeFile = $root . '/README.md';
    $begin = '<!-- BEGIN ACTIONS -->';
    $end = '<!-- END ACTIONS -->';

    $readme = \file_get_contents($readmeFile);

    if (!\is_string($readme)) {
        \fwrite(
            \STDERR,
            "Could not read README.md.\n",
        );

        exit(1);
    }

    $pattern = \sprintf(
        '/^%s$.*^%s$/ms',
        \preg_quote(
            $begin,
            '/',
        ),
        \preg_quote(
            $end,
            '/',
        ),
    );

    if (\preg_match($pattern, $readme) !== 1) {
        \fwrite(\STDERR, \sprintf(
            "README.md needs to contain the markers \"%s\" and \"%s\".\n",
            $begin,
            $end,
        ));

        exit(1);
    }

    $iterator = new \RecursiveIteratorIterator(new \RecursiveDirectoryIterator(
        $root . '/actions',
        \FilesystemIterator::SKIP_DOTS,
    ));

    $actions = [];

    foreach ($iterator as $file) {
        if ($file->getFilename() !== 'action.yaml') {
            continue;
        }

        $actions[] = \substr(
            $file->getPath(),
            \strlen($root) + 1,
        );
    }

    \sort(
        $actions,
        \SORT_STRING,
    );

    $list = [];
    $sections = [];

    foreach ($actions as $action) {
        $anchor = \str_replace(
            '/',
            '-',
            \substr(
                $action,
                \strlen('actions/'),
            ),
        );

        $list[] = \sprintf(
            '- [`ergebnis/.github/%s`](#%s)',
            $action,
            $anchor,
        );

        $documentationFile = $root . '/' . $action . '/README.md';

        if (!\is_file($documentationFile)) {
            \fwrite(\STDERR, \sprintf(
                "%s/README.md does not exist.\n",
                $action,
            ));

            exit(1);
        }

        $documentation = \file_get_contents($documentationFile);

        if (!\is_string($documentation)) {
            \fwrite(\STDERR, \sprintf(
                "Could not read %s/README.md.\n",
                $action,
            ));

            exit(1);
        }

        $lines = \explode(
            "\n",
            $documentation,
        );

        $description = [];

        $linesAfterTitle = \array_slice(
            $lines,
            1,
        );

        foreach ($linesAfterTitle as $line) {
            if (\strpos($line, '```') === 0) {
                break;
            }

            $description[] = $line;
        }

        $sections[] = \implode("\n", [
            \sprintf(
                '### <a name="%s"> `ergebnis/.github/%s`',
                $anchor,
                $action,
            ),
            '',
            \trim(\implode(
                "\n",
                $description,
            )),
            '',
            \sprintf(
                '💡 Find out more in the documentation for [`ergebnis/.github/%s`](%s/README.md).',
                $action,
                $action,
            ),
        ]);
    }

    $generated = \implode("\n\n", [
        $begin,
        'This project provides the following composite actions:',
        \implode(
            "\n",
            $list,
        ),
        \implode(
            "\n\n",
            $sections,
        ),
        $end,
    ]);

    $replaced = \preg_replace_callback(
        $pattern,
        static function () use ($generated): string {
            return $generated;
        },
        $readme,
    );

    if (!\is_string($replaced)) {
        \fwrite(
            \STDERR,
            "Could not replace the composite actions in README.md.\n",
        );

        exit(1);
    }

    $written = \file_put_contents(
        $readmeFile,
        $replaced,
    );

    if ($written === false) {
        \fwrite(
            \STDERR,
            "Could not write README.md.\n",
        );

        exit(1);
    }
})();
