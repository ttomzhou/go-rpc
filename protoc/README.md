### protoc的安装

### protobuf文件编写
一般情况下会将`编译生成的pb.go`文件生成在与`proto`文件相同的目录。
##### package
`package`属于proto文件自身的范围定义，与生成的go代码无关。是为了避免当导入其他proto文件时导致文件内的命名冲突。

##### option

- `option go_package="module/pb.go目录"`的声明与生成的go代码相关。`它定义了生成的go文件所属包的完整包名（相对于该项目的完整的包路径），应以项目的Module Name为前缀`。 

##### import
- import 不允许使用相对路径`Backslashes, consecutive slashes, ".", or ".." are not allowed in the virtual path`
- import 导入路径应该从`根开始的绝对路径`
- 同属于一个包内的proto文件之间的引用也需要声明import
- 导入非本地包的`message`时，需要加package前缀。格式：`package.message`

    - 例如引入的grpc-gateway时，package="google.api"；引入其中http属性为：google.api.http
- 导入本地包时：

    - 同包内的引用不需要加包名前缀
    - 不同包的引用需要加包前缀，eg：user.proto引用common.proto的CommonRequest属性【common.CommonRequest】

### protoc的命令
多包编译存在问题`https://github.com/golang/protobuf/issues/39`在`https://github.com/protocolbuffers/protobuf-go`的v1.20.0之后支持多包编译。

#### 格式：`protoc [OPTION] PROTO_FILES`
##### OPTION选项
- `-I`或`--proto_path`
用于指定所编译源码（包括直接编译的和被导入的proto文件)的搜索路径。`proto`文件使用`import`关键字导入的路径一定是要基于`--proto_path`或`-I`参数所指定的路径的，该参数如果不指定，默认为`pwd`路径，也可以指定多个所有包含所需文件。
- `--go_out`
> 格式：--go_out=pliugins=grpc,paths=imports:.
或者--go_out=pliugins=grpc,paths=source_relative:.
默认为import方式

参数用来指定`protoc-gen-go`插件的工作方式和go代码目录架构生成位置。[golang/protobuf文档](https://github.com/golang/protobuf#parameters)。主要两个参数`plugins`(生成go代码所使用的插件),`paths`(生成go代码的目录位置)。
- [x] paths参数：import、source_relative。
- import：代表按照生成的go代码的包全路径去创建目录层级。
- source_relative代表按照proto源文件的目录去创建go代码的目录层级，如果目录已存在则不用创建。

### protobuf官方地址
- [import其他proto文件说明](https://mileslin.github.io/2020/04/Golang/Import-%E5%85%B6%E4%BB%96-proto/)
- [protobuf文档](https://developers.google.com/protocol-buffers/docs/reference/overview)
- [grpc文档](https://www.grpc.io/docs/what-is-grpc/)
- [proto-gen-grpc](https://github.com/grpc/grpc-go)
- [grpc-gateway代理](https://github.com/grpc-ecosystem/grpc-gateway)
- [validate参数校验](https://github.com/envoyproxy/protoc-gen-validate)
- [protobuf](https://github.com/golang/protobuf)
- [protoc-gen-go](https://github.com/protocolbuffers/protobuf-go)
- [googleapis](https://github.com/googleapis/googleapis)
- [protocol buffer插件列表](https://github.com/protocolbuffers/protobuf/blob/master/docs/third_party.md)
- [google.api的proto插件](https://github.com/googleapis/googleapis/blob/master/google/api/field_behavior.proto)