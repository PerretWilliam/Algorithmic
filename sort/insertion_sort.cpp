#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>
#include <chrono>

#include "sort.hpp"

void insertion_sort(std::vector<int> &vector)
{
  for (size_t i = 1; i < vector.size(); i++)
  {
    int value = vector[i];
    size_t j = i;
    while (j > 0 && vector[j - 1] > value)
    {
      vector[j] = vector[j - 1];
      j--;
    }
    vector[j] = value;
  }
}

size_t measure_time(std::vector<int> &vector)
{
  std::chrono::steady_clock::time_point t_start = std::chrono::steady_clock::now();

  insertion_sort(vector);

  std::chrono::steady_clock::time_point t_end = std::chrono::steady_clock::now();
  size_t duration = std::chrono::duration_cast<std::chrono::microseconds>(t_end - t_start).count();

  return duration;
}