/*!
 * \brief Defines functions to load the data that Nova needs to load
 *
 * This file is intended as the public interface of the data loading module
 *
 * \author ddubois 
 * \date 03-Sep-16.
 */

#ifndef RENDERER_LOADERS_H
#define RENDERER_LOADERS_H

#include <string>
#include <unordered_map>

#include "../gl/gl_shader_program.h"

namespace nova {
    namespace model {
        /*!
         * \brief Loads the shaderpack with the given name
         *
         * \param shaderpack_name The name of the shaderpack to load
         * \return The loaded shaderpack
         */
        std::unordered_map<std::string, gl_shader_program> load_shaderpack(const std::string& shaderpack_name);
    }
}

#endif //RENDERER_LOADERS_H
