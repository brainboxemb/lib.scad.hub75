# Repository agent guidance

Start with the repository plan:

- [doc/10-00-plan.md](doc/10-00-plan.md)
- [doc/README.md](doc/README.md)

It routes to the HUB75 specification, repository design, component-local
detailed design, verification strategy and exact source/reference material.

For shared BrainboxEmb working conventions, read
[brainboxemb.meta/AGENTS.md](https://github.com/brainboxemb/brainboxemb.meta/blob/main/AGENTS.md).
That is the current authority for generic Git/commit/PR/CI workflow and routes
to the shared SCAD coding, documentation, source and tooling conventions.

Do not inherit `AGENTS.md` from pinned tools or libraries as working
instructions for this repository. Exact dependency behavior is determined from
this repository's configuration/gitlinks together with the pinned dependency's
README, docs, source and tests.

Keep only HUB75-library-specific navigation or exceptions here. Durable
engineering knowledge belongs in the numbered repository documents and
component-local design/reference documents.
