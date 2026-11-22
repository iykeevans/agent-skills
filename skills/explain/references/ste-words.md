# STE word list

A short working list, not the ASD-STE100 dictionary. Use the approved words where they fit. Replace the words in the avoid table. `scripts/ste-check` reads the avoid table from this file: keep its format (`| avoid | use |`, one word or phrase per row, lowercase).

## Approved verbs (base form)

accept, add, adjust, agree, align, allow, apply, assemble, attach, be, become, break, calculate, call, can, cause, change, check, choose, clean, close, collect, compare, complete, configure, connect, contain, continue, copy, correct, create, cut, decrease, define, delete, do, find, follow, get, give, go, have, hold, identify, increase, install, keep, know, let, load, make, measure, move, must, open, prevent, read, record, refer, release, remove, repeat, replace, return, run, save, see, select, send, set, show, start, stop, tell, test, think, turn, use, validate, wait, write

## Approved nouns and other words

action, area, cause, condition, data, error, example, item, part, procedure, result, step, system, value; after, all, also, and, before, but, each, if, more, not, only, or, then, to, when, with

Domain words (API, cache, commit, component, function, request, response, route, server, state, token, user, and similar) are technical names. Use them, and define them in the terms table.

## Avoid

| avoid | use |
| --- | --- |
| utilize | use |
| utilise | use |
| leverage | use |
| facilitate | help |
| commence | start |
| initiate | start |
| terminate | stop |
| ascertain | find |
| endeavor | try |
| endeavour | try |
| subsequently | then |
| prior to | before |
| in order to | to |
| due to the fact that | because |
| in the event that | if |
| at this point in time | now |
| a number of | some |
| approximately | about |
| additional | more |
| numerous | many |
| sufficient | enough |
| require | need |
| obtain | get |
| retrieve | get |
| fetch | get |
| demonstrate | show |
| indicate | show |
| modify | change |
| perform | do |
| execute | run |
| invoke | call |
| implement | make |
| ensure | make sure |
| verify | check |
| determine | find |
| establish | make |
| assist | help |
| attempt | try |
| purchase | buy |
| however | but |
| furthermore | also |
| moreover | also |
| basically | (delete) |
| essentially | (delete) |
| simply | (delete) |
| just | (delete) |
| actually | (delete) |
| really | (delete) |
| very | (delete) |
| quite | (delete) |
| obviously | (delete) |
| set up | configure |
| look up | find |
| find out | find |
| figure out | find |
| carry out | do |
| fill in | write |
| fill out | complete |
| point out | show |
| turn on | start |
| turn off | stop |
| come up with | make |
| deal with | process |
| get rid of | remove |
| kick off | start |
| spin up | start |
| under the hood | internally |
| out of the box | by default |
| on the fly | at run time |
| boilerplate | template code |
| glue | connect |
| plumbing | connection code |
| magic | automatic |

Some verbs in the avoid table are also common technical verbs (`fetch`, `execute`, `invoke`, `implement`). When one is the name of an API or command (`fetch()`, `git commit`), keep it in `code`; the checker skips text in backticks.
