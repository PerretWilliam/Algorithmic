#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>
#include <chrono>

#include "sort.hpp"

void bubble_sort(std::vector<int> &vecteur)
{
  for (size_t i = 0; i < vecteur.size(); i++)
  {
    for (size_t j = 0; j < vecteur.size() - 1; j++)
    {
      if (vecteur[j] > vecteur[j + 1])
      {
        std::swap(vecteur[j], vecteur[j + 1]);
      }
    }
  }
}

size_t measure_time(std::vector<int> &vector)
{
  std::chrono::steady_clock::time_point t_start = std::chrono::steady_clock::now();

  bubble_sort(vector);

  std::chrono::steady_clock::time_point t_end = std::chrono::steady_clock::now();
  size_t duration = std::chrono::duration_cast<std::chrono::microseconds>(t_end - t_start).count();

  return duration;
}
