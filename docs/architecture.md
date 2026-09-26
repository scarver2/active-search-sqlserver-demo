<!-- docs/architecture.md -->
# Architecture

Rails talks to SQL Server only through Active Record and activerecord-sqlserver-adapter. Active
Search stores denormalized Article documents in article_documents. SQL Server's native full-text
index covers title and content; CONTAINSTABLE supplies matching keys and relevance rank.

TinyTDS remains an implementation detail of the Active Record adapter.

—
Stan Carver II
Made in Texas 🤠
https://stancarver.com
