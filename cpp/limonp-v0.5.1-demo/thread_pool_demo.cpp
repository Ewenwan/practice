// 线程池=========================================
// 
#include "limonp/ThreadPool.hpp"
#include "limonp/StdExtension.hpp"
#include <unistd.h> // for function: usleep   sleep函数

using namespace std;// 命名空间

const size_t THREAD_NUM = 4;// 线程数量

class Foo 
{
 public:
  void Append(char c) 
  {
    limonp::MutexLockGuard lock(mutex_);// 线程互斥锁，守卫，守护该线程
   // 这个类成员函数Append会在多个线程中被调用，多个线程同时对chars这个类成员变量
   // 进行写操作，所以需要加锁保护线程安全
    chars.push_back(c);// 连接字符串
    usleep(10*1000); // just for make chars more disorder
  }

  string chars;// 多线程贡献的字符串对象
  limonp::MutexLock mutex_;// 线程 互斥锁
};

// 调用类的函数============
void DemoClassFunction() 
{
  Foo foo;
  cout << foo.chars << endl;// 打印字符串
  limonp::ThreadPool thread_pool(THREAD_NUM);// 初始化一个线程池，使用队列实现
  thread_pool.Start();// 启动线程池
  for (size_t i = 0; i < 20; i++) // 循环20次
  {
    char c = i % 10 + '0';//形成字符
    thread_pool.Add(limonp::NewClosure(&foo, &Foo::Append, c));
    // 该闭包创建函数较为简单，只考虑值拷贝，不考虑引用类型参数。
    // 第一个参数为 类对象的指针
    // 第二个对象为 成员函数的指针
    // 第三个是 int类型的函数参数， 它们都是值传递，不支持引用传递
    // 使用 NewClosure（闭包）绑定 foo 类对象 和 其成员函数 Append 和其函数参数
    // 构造一个闭包扔进线程池中运行
  }
  thread_pool.Stop();// 等待所有线程工作都完成(指NewClosure生成的闭包函数 都完成)，然后停止所有线程
  cout << foo.chars << endl;
}

int main() {
  DemoClassFunction();
  return 0;
}
