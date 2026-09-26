<!-- README.md -->
# Active Search SQL Server Demo

A Rails 8.1 application demonstrating the proposed Microsoft SQL Server adapter for Basecamp's
Active Search against real SQL Server 2022 Full-Text Search.

## Setup

1. Run bin/setup.
2. Run bin/test.
3. Run bin/rails server.
4. Open http://localhost:3000 and search the deterministic Article data.

The setup command builds SQL Server with mssql-server-fts, verifies FTS availability, creates the
databases, migrates, seeds, and indexes the articles.

Useful commands include bin/up, bin/down, bin/status, bin/doctor, and bin/test.

## Behavior

The seed corpus covers terms, phrases, ranking, searchable fields, filters, Unicode, punctuation,
NULL content, stopwords, inflection, and zero-result searches. SQL Server relevance and linguistic
analysis are native to its English word breaker and differ from other engines. Highlighting is not
part of the proposed initial adapter.

See docs/architecture.md and docs/testing.md.

## License

MIT. Copyright 2026 Stan Carver II.

—
Stan Carver II
Made in Texas 🤠
https://stancarver.com
