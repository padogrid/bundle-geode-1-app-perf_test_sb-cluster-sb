# Type 1 Recovery Steps

In Type 1, cache servers are isolated. The recovery steps are similar to Type 2.

1. Fix network issues if any.
2. Check if the isolated members sucessfully rejoin the cluster.
3. If isolated members are unable rejoined the cluster then gracefully stop them.
4. Check each isolated member's CPU usage and available system resources.
5. Identify the members that ran out of system resources.
6. Increase system resources as needed for those members.
7. Restart the stopped members.
8. Wait for GemFire to auto-recover the restarted members.
9. Once the restarted members have successfully rejoined the cluster, check for data loss.
10. GemFire is expected to fully recover persistent data.
11. Reingest non-persistent data.
