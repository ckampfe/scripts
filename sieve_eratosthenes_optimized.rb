# this is an optimized version (over 10x faster), that only checks numbers up to the sqrt of n
# how neat is that?

def opt_eratosthenes_sieve(n)
  nums = 2.upto(n).to_a

  2.upto(n ** 0.5) do |a_num|
    nums.keep_if { |unc| unc % a_num != 0 || unc == a_num }
  end

  nums
end
