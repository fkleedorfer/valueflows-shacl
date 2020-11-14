# Tools
- Recommended, seemingly very powerful: fast-downward. 
    * hassle to get running interface would have to be via text files 
        (generate pddl problems, parse solutions)
- Online tool: https://web-planner.herokuapp.com/
- PDDL4j - authors may keep more powerful planners for commercial add-on. Basic search algorithms are present
- Option: convert pddl to ASP, then solve with clingo: https://github.com/potassco/plasp

## running
```
docker run --rm -v "c:\DATA\DEV\workspace\valueflows-shacl\pddl\playground":/benchmarks aibasel/downward --plan-file /benchmarks/plan /benchmarks/domain.pddl /benchmarks/move-recipe/problem-taxi.pddl --search "eager_wastar([hmax()])"
```

Good results for problem-transport-complex.pddl
```
docker run --rm -v "c:\DATA\DEV\workspace\valueflows-shacl\pddl\playground":/benchmarks aibasel/downward --search-time-limit 30 --sas-file /benchmarks/sas --plan-file /benchmarks/plan /benchmarks/domain.pddl /benchmarks/move-recipe/problem-transport-complex.pddl --search "eager(open=pareto([ff(),hmax(),add(),goalcount()]))"
```