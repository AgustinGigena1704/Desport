using Microsoft.AspNetCore.Components;

namespace CCC.Api.Services
{
    public class NavManager : NavigationManager
    {
        public NavManager(string baseUri, string uri)
        {
            Initialize(baseUri, uri);
        }
    }
}
