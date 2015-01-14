# glusterfs Cookbook

![Travis Button](https://travis-ci.org/osuosl-cookbooks/glusterfs.svg)

The glusterfs cookbook installs the client libraries from the Gluster project
upstream repository.

## Supported Platforms

* CentOS 6.6

## Attributes

* ``default['glusterfs']['version']`` -- Major version to be installed. By
  default set to ``LATEST`` which will install the latest version. Please
  consult the [upstream
  repo](http://download.gluster.org/pub/gluster/glusterfs/) for specific
  versions you can use.

## Recipes

### glusterfs::default

Include `glusterfs` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[glusterfs::default]"
  ]
}
```

## TODO

* [ ] Add support for distribution packages
* [ ] Add support for Debian/Ubuntu
* [ ] Add server support
* [ ] Add mounting support
* [ ] Add resources to manage gluster bricks

## License and Authors

Author:: Oregon State University (<chef@osuosl.org>)

```text
Copyright:: 2015 Oregon State University

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
