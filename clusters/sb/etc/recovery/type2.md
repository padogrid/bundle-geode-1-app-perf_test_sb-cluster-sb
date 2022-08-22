# Type 2 Recovery Steps

In Type 2, locators and cache servers are isolated. In this scenario, a true split-brain may occur due to each split having at least one locator. In that case, clients will be able to connect to either split. The recovery steps are similar to Type 1.

1. Fix network issues if any.
2. Check if the isolated members sucessfully rejoin the cluster.
3. If isolated members are unable to rejoin the cluster then gracefully stop them.
4. Check each isolated member's CPU usage and available system resources.
5. Identify the members that ran out of system resources.
6. Increase system resources as needed for those members.
7. Restart the stopped members.
8. Wait for GemFire to auto-recover the restarted members.
9. Once the restarted members have successfully rejoined the cluster, check for data loss.
10. GemFire is expected to fully recover persistent data.
11. Reingest non-persistent data.
