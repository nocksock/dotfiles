# -*- mode: snippet -*-
# name: useOutsideClick
# uuid: useOutsideClick
# key: trigger-key
# condition: t
# --

export const useOutsideClick = (ref, callback) => {
    React.useEffect(() => {
        const handleClickOutside = event => {
            const aRef = Array.isArray(ref) ? ref : [ref];
            if (
                aRef.every(r => r.current && !r.current.contains(event.target))
            ) {
                callback(event);
            }
        };

        document.addEventListener('mousedown', handleClickOutside);

        return () => {
            document.removeEventListener('mousedown', handleClickOutside);
        };
    }, [ref]);
};
