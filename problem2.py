def simplify_path(path):
    components = path.split('/')

    stack = []

    for component in components:
        if component == "..":
            if stack:
                stack.pop()
        elif component and component != ".":
            stack.append(component)

    simplified_path = "/" + "/".join(stack)

    return simplified_path

# test case
path1 = "/home/"
path2 = "/a/./b/../../c/"
path3 = "/fic/././iak/../../hgy/blg/../vzt/../tod/.././.././bsc/./krk/../lnb/zhj/./"

print(simplify_path(path1))  # Output: "/home"
print(simplify_path(path2))  # Output: "/c"
print(simplify_path(path3))  # Output: "/bsc/lnb/zhj"
