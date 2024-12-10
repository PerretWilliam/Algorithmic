#include <iostream>
#include <vector>
#include <chrono>
#include <algorithm>

#include "sort.hpp"

void ICantBelieveItCanSort(std::vector<int> &vector)
{
  const size_t SIZE = vector.size();
  for (int i = 0; i < SIZE; ++i)
  {
    for (int j = 0; j < SIZE; ++j)
    {
      if (vector[i] < vector[j])
      {
        std::swap(vector[i], vector[j]);
      }
    }
  }
}

size_t measure_time(std::vector<int> &vector)
{
  std::chrono::steady_clock::time_point t_start = std::chrono::steady_clock::now();

  ICantBelieveItCanSort(vector);

  std::chrono::steady_clock::time_point t_end = std::chrono::steady_clock::now();
  size_t duration = std::chrono::duration_cast<std::chrono::microseconds>(t_end - t_start).count();

  return duration;
}
