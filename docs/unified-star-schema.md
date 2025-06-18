# Unified Star Schema Approach

The Unified Star Schema (USS) is a pattern for organizing analytical data models
that makes complex business domains easier to work with. Rather than building
many separate star schemas, USS proposes a single, coherent star-style model
where dimension tables can be reused across different subject areas.

For a detailed discussion see the [Agile Lab blog post](https://www.agilelab.it/blog/unified-star-schema-to-model-data-products).

## Benefits

* **Simplifies joins.** Facts share common dimensions so analysts do not need to
  perform intricate join logic across many snowflaked tables.
* **Improves consistency.** A common set of dimensions encourages standardized
  metric definitions and helps avoid duplicated logic across data products.
* **Eases governance.** Centralized dimensions allow data owners to manage
  attributes and descriptions in one place, reducing the risk of divergent data
  definitions.
* **Speeds up onboarding.** New consumers have fewer tables to explore and can
  rely on familiar dimensions for different fact tables.

USS is particularly helpful when several data products share similar
entities—such as customers, orders, or products—because it provides a clear
structure for collaborating teams without losing the advantages of a star
schema.
