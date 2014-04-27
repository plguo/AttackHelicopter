typedef NS_OPTIONS(uint32_t, CategoryBitMaskOpition){
    CategoryNone = 0,
    CategoryTile = 0x1 << 0,
    CategoryHelicopter = 0x1 << 1,
    CategoryFriendWeapon = 0x1 << 2,
    CategoryEnemyObject = 0x1 << 3,
    CategoryEnemyWeapon = 0x1 << 4
};