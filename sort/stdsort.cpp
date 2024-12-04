#include <iostream>
#include <vector>
#include <algorithm>
#include <cstdlib>
#include <ctime>
#include <chrono>
#include <thread>
#include <atomic>

#include "sort.hpp"

size_t measure_time(std::vector<int> &vector)
{

  std::chrono::steady_clock::time_point t_start = std::chrono::steady_clock::now();

  std::sort(vector.begin(), vector.end());

  std::chrono::steady_clock::time_point t_end = std::chrono::steady_clock::now();
  size_t duration = std::chrono::duration_cast<std::chrono::microseconds>(t_end - t_start).count();

  return duration;
}
