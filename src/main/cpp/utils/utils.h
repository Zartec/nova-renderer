/*!
 * \brief Contains a bunch of utility functions which may or may not be actually used anywhere
 *
 * \author David
 * \date 18-May-16.
 */

#ifndef RENDERER_UTILS_H
#define RENDERER_UTILS_H

#include <vector>
#include <string>
#include <algorithm>
#include <exception>


/*!
 * \brief Initializes the logging system
 */
void initialize_logging();

namespace nova {
    /*!
     * \brief Calls the fucntion once for every element in the provided container
     *
     * \param container The container to perform an action for each element in
     * \param thingToDo The action to perform for each element in the collection
     */
    template <typename Cont, typename Func>
    void foreach(Cont container, Func thingToDo) {
        /* Test for GCC > 5.1
         * global functions cbegin, cend, rbegin, rend, crbegin, and crend added in this version */
        #if __GNUC__ > 5 || (__GNUC__ == 5 && (__GNUC_MINOR__ > 1))
        std::for_each(std::cbegin(container), std::end(container), thingToDo);
        #else
        std::for_each(container.begin(), container.end(), thingToDo);
        #endif
    };

    /*!
     * \brief Simple exception to represent that a resouce can not be found
     */
    class resource_not_found : public std::exception {
    public:
        resource_not_found(const std::string& msg);
        virtual const char * what() const noexcept;
    private:
        std::string message;
    };
}

#endif //RENDERER_UTILS_H
