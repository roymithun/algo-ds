// https://www.interviewbit.com/problems/best-time-to-buy-and-sell-stocks-i/
func maxProfitBuySellStocks1(_ A: [Int]) -> Int {
    if A.isEmpty {
        return 0
    }
    var maxProfit = 0
    var buy = A[0]
    for i in 1..<A.count {
        if buy > A[i] {
            buy = A[i]
        } else if A[i] - buy > maxProfit {
            maxProfit = A[i] - buy
        }
    }
    return maxProfit
}
print(maxProfitBuySellStocks1([1, 4, 5, 2, 4]))

// https://www.interviewbit.com/problems/best-time-to-buy-and-sell-stocks-ii/
func maxProfit(_ A: [Int]) -> Int {
    if A.isEmpty {
        return 0
    }
    var maxProfit = 0
    for i in 1 ..< A.count {
        if A[i] > A[i-1] {
            maxProfit += A[i] - A[i-1]
        }
    }
    return maxProfit
}

// https://www.interviewbit.com/problems/kingdom-war/
func solveKindomWar(_ A: inout [[Int]]) -> Int {
    let n = A.count
    let m = A[0].count
    var result = Int.min
    
    var dp = [[Int]](repeating: [Int](repeating: 0, count: m + 1), count: n + 1)
    for i in stride(from: n, through: 0, by: -1) {
        for j in stride(from: m, through: 0, by: -1) {
            if i == n || j == m {
                dp[i][j] = 0
                continue
            }
            dp[i][j] = A[i][j] + dp[i + 1][j] + dp[i][j + 1] - dp[i + 1][j + 1]
            result = max(result, dp[i][j])
        }
    }
    return result
}

// https://www.interviewbit.com/problems/longest-common-subsequence/
func solveLCS(_ A: inout String, _ B: inout String) -> Int {
    let m = A.count
    let n = B.count
    
    let a = Array(A)
    let b = Array(B)
    
    var dpArray = [[Int]](repeating: [Int](repeating: -1, count: n + 1), count: m + 1)
    // memoization
    func lcsTopDown(_ a: Array<Character>, _ b: Array<Character>, _ m: Int, _ n: Int) -> Int {
        if m == 0 || n == 0 {
            return 0
        }
        
        if dpArray[m][n] != -1 {
            return dpArray[m][n]
        }
        
        var x = 0
        if a[m - 1] == b[n - 1] {
            x = 1 + lcsTopDown(a, b, m - 1, n - 1)
        } else {
            x = max(lcsTopDown(a, b, m - 1, n), lcsTopDown(a, b, m, n - 1))
        }
        dpArray[m][n] = x
        return x
    }
    
    // tabulation
    func lcsBottomUp() -> Int {
        var dp = [[Int]](repeating: [Int](repeating: -1, count: n + 1), count: m + 1)
        for i in 0 ... m {
            for j in 0 ... n {
                if i == 0 || j == 0 {
                    dp[i][j] = 0
                } else if a[i - 1] == b[j - 1] {
                    dp[i][j] = 1 + dp[i - 1][j - 1]
                } else {
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
                }
            }
        }
        return dp[m][n]
    }
    return lcsTopDown(a, b, m, n)
}
var str1 = "abbcdgf"
var str2 = "bbadcgf"

solveLCS(&str1, &str2)
