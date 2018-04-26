﻿// Licensed to the Swastika I/O Foundation under one or more agreements.
// The Swastika I/O Foundation licenses this file to you under the MIT license.
// See the LICENSE file in the project root for more information.

using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Swastika.Identity.Data;
using Swastika.Identity.Models;

namespace Swastika.Identity
{
    public class Startup
    {
        public static void ConfigIdentity(
            IServiceCollection services, IConfigurationRoot Configuration, string connectionName)
        {
            string connectionString = Configuration.GetConnectionString(connectionName);
            if (string.IsNullOrEmpty(connectionString))
            {
                connectionString = "Server=(localdb)\\mssqllocaldb;Database=aspnet-Swastika.Cms.Db;Trusted_Connection=True;MultipleActiveResultSets=true";
            }

            services.AddDbContext<ApplicationDbContext>(options =>
                options.UseSqlServer(connectionString));

            PasswordOptions pOpt = new PasswordOptions()
            {
                RequireDigit = false,
                RequiredLength = 6,
                RequireLowercase = false,
                RequireNonAlphanumeric = false,
                RequireUppercase = false
            };

            services.AddIdentity<ApplicationUser, IdentityRole>(options =>
            {
                options.Password = pOpt;
            })
                .AddEntityFrameworkStores<ApplicationDbContext>()
                .AddDefaultTokenProviders()
                .AddUserManager<UserManager<ApplicationUser>>();

            services.AddAuthorization(options =>
            {
                options.AddPolicy("AddEditUser", policy =>
                {
                    policy.RequireClaim("Add User");
                    policy.RequireClaim("Edit User");
                });
                options.AddPolicy("DeleteUser", policy => policy.RequireClaim("Delete User"));
            })
             ;
        }
    }
}